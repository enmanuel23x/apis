const express = require('express')
const cors = require('cors')
const axios = require('axios')
const delay = require('delay');
//project's own requires
const router = express.Router()
const pool = require('../db/database');

//initialization
const TrelloAxios = axios.create({
    baseURL: 'https://api.trello.com/1'
});
TrelloAxios.defaults.headers.post['Content-Type'] = 'application/json';

const ClockifyAxios = axios.create({
    baseURL: 'https://api.clockify.me/api/v1'
});
ClockifyAxios.defaults.headers.common['Content-Type'] = 'application/json';
ClockifyAxios.defaults.headers.common['X-Api-Key'] = 'Xvy1392jqzm2LxBF';

axios.defaults.baseURL = 'https://api.clockify.me/api/v1'
axios.defaults.headers.common['X-Api-Key'] = 'Xvy1392jqzm2LxBF'
axios.defaults.headers.common['content-type'] = 'application/json'
//const userId = '5e1f5dc2b4e9df3331a30d80'
const workspaceId = '5c79aee1b079877a63415e08'
const add = '?key=97ed379704c2ca46cc6de86a6f0fa31f&token=dab44b231906a2484ee48d2fe11704046651e0083c6e71da3727f33589abd728';
//'?key=97ed379704c2ca46cc6de86a6f0fa31f&token=dab44b231906a2484ee48d2fe11704046651e0083c6e71da3727f33589abd728';
//'?key=5d94aa42b86a6f4e11d7cd857ff8699a&token=22b262d7b19e02d785a2b1fa0ba982e55ab891122b07d7ff79ffda934f7a4e28';

//routes
router.get('/', async (req, res) => {
    data = await getMembersEmail();
    res.json({data})
})

router.post('/getUsers', async (req, res) => { 
    const { email } = req.body
    data = await getUsers(email);
    res.json({data})

})

router.post('/getProjects', (req, res) => { 
    const { name } = req.body
    axios.get(`/workspaces/${workspaceId}/projects`, { params: { name: name }})
    .then (resp => {
        projects = resp.data
        res.json({
            name
            //projects
        })
    })
    .catch (error => {
        res.json({
            error
        })
    })
    //data = await getUsers(email);
    //res.json({data})
})

router.post('/getTasks', (req, res) => { 
    const { name, projectId } = req.body
    axios.get(`/workspaces/${workspaceId}/projects/${projectId}/tasks`,{ params: { name: name }})
    .then (resp => {
        tasks = resp.data
        res.json({
            projectId,
            tasks
        })
    })
    .catch (error => {
        res.json({
            error
        })
    })
})

router.get('/getTime', async (req, res) => {
    const data = await pool.query(`SELECT act_mail FROM activities where act_title = 'false' AND (act_card_end = 1 OR act_card_end = 2)`)
    let emails = data.map(email => email.act_mail)
    let emailsFiltered = []
    let cont = 0;
    emails.forEach((email, i)=>{
      if(!emailsFiltered.includes(email)){
        emailsFiltered[i]=email
      }
    })
    emailsFiltered.forEach(async email => {
    
    const userId = await getUserID(email)
    const activities = await pool.query(`SELECT * FROM activities WHERE act_mail = '${email}' AND act_title = 'false' AND (act_card_end = 1 OR act_card_end = 2)`)
    let descps = activities.map(activity => activity.act_trello_name)
      async function process(descp, j){
        await delay(7000);
        const data = await getTimeEntries(userId, descp)
        if(data.length > 0){
            var time = {}
            var min = 0
            var totalmin = 0
            var totalhours = 0
            data.forEach(async (dat, i) => {
                oldFormat = data[i].timeInterval.duration
                newFormat = oldFormat.split('PT')
                isH = checkH(newFormat[1])
                isM = checkM(newFormat[1])
                isS = checkS(newFormat[1])
                timeFormatted = formatTime(isH, isM, isS)
                time[i] = {
                    "description": data[i].description,
                    "hours": timeFormatted[0],
                    "minutes": timeFormatted[1],
                    "seconds": timeFormatted[2]
                }
                min = (parseInt(timeFormatted[0])*60) + parseInt(timeFormatted[1])
                totalmin += min
            })
            totalhours = Math.round((totalmin / 60)*100)/100
            try{
              const request = await pool.query(`UPDATE activities SET act_time_loaded = '${totalhours}' WHERE act_trello_name = '${descps[j]}' `)
              await delay(3000);
              await delay(3000);
              cont++;
              if(descps.length == cont){
                await delay(3000);
                await updateDesvPercent();
                await updateDesvPercent2();
                res.send("listo2")
              }
              return 0;
            }catch(error){
              cont++;
              if(descps.length == cont){
                await delay(3000);
                await updateDesvPercent()
                await updateDesvPercent2();
                res.send("listo2")
              }
              return 0;
            }
        }else{
          cont++;
          if(descps.length == cont){
            await delay(3000);
            await updateDesvPercent()
            await updateDesvPercent2();
            res.send("listo2")
          }
          return 0;
        }
      }
      for(j=0;j<descps.length;j++){
        await delay(3000);
        await process(descps[j], j)
      }
    await delay(3000);
  })
})

router.get('/actualizar', async (req, res)=>{
  await delay(3000);
  await updateTrelloCard()
  await pool.query('UPDATE activities SET act_card_end = 3 WHERE act_card_end = 2');
  res.send('listo')
})
router.post('/getEntrie', async (req, res) => { 
    const { email, description } = req.body
    const userID = await getUserID(email);
    axios.get(`/workspaces/${workspaceId}/user/${userID}/time-entries?description=${description}`)
        .then (Response => {
            res.json(Response.data)
            })
        .catch (error => {
            //console.log(error)
            res.json({
                error
            })
        });
})



//functions
function getUser(){
    return new Promise(async (resolve,reject) => {
        try {
          const result = await ClockifyAxios.get('/user');
          resolve(result.data)
        } catch (error) {
            //console.log(error)
          reject(error)
        }
      });
}

function getUsers(email) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await ClockifyAxios.get(`/workspaces/${workspaceId}/users`, { params: { email: email }});
          resolve(result.data)
        } catch (error) {
            //console.log(error)
          reject(error)
        }
      });
}

function getProject(params) {
    
}

function formatTime(isH, isM, isS) {
    hours= 0
    seconds= 0
    minutes= 0
    if(isH > 0 && isM > 0 && isS > 0){
        splitH = newFormat[1].split('H')
        hours = splitH[0]
        splitM = splitH[1].split('M')
        minutes = splitM[0]
        splitS = splitM[1].split('S')
        seconds = splitS[0]
    }else if (isH > 0 && isM > 0 && isS < 0) {
        splitH = newFormat[1].split('H')
        hours = splitH[0]
        splitM = splitH[1].split('M')
        minutes = splitM[0]
    }else if (isH > 0 && isS > 0 && isM < 0){
        splitH = newFormat[1].split('H')
        hours = splitH[0]
        splitS = splitH[1].split('S')
        seconds = splitS[0]
    }else if (isM > 0 && isS > 0 && isH < 0){
        splitM = newFormat[1].split('M')
        minutes = splitM[0]
        splitS = splitM[1].split('S')
        seconds = splitS[0]
    }else if( isH > 0 && isM < 0 && isS < 0){
        splitH = newFormat[1].split('H')
        hours = splitH[0]
    }else if( isH == -1 && isM >= 0 && isS == -1){

        splitM = newFormat[1].split('M')
        minutes = splitM[0]
    }else if( isH < 0 && isM < 0 && isS > 0){
        splitS = newFormat[1].split('S')
        seconds = splitS[0]
    }
    let time = [hours, minutes, seconds]
    return time
}

function getTimeEntries(userId, descp) {

    return new Promise(async (resolve,reject) => {
        try {
            const params = {
                description: descp,
            }
          const result = await ClockifyAxios.get(`/workspaces/${workspaceId}/user/${userId}/time-entries`, {params})
          resolve(result.data)
        } catch (error) {
            //console.log(error)
          reject(error)
        }
      });

    
    
}

async function updateTrelloCard() {
    const activities = await pool.query(`select * from activities LEFT JOIN request ON activities.req_id = request.req_id where act_title = 'false' AND act_time_loaded != 0 AND (act_card_end = 1 OR act_card_end = 2)`)
    let boardIds = activities.map(board => board.board_id)
    let boardIdsFiltered = []
    boardIds.forEach((boardId, i)=>{
    if(!boardIdsFiltered.includes(boardId)){
      boardIdsFiltered[i] = boardId
    }
  })
  boardIdsFiltered.forEach(idBoard =>{
    axios.get(`https://api.trello.com/1/boards/${idBoard}/customFields${add}`)
    .then(resp =>{
        cf = resp.data
        camposP = {}
        for (let i = 0; i < activities.length; i++) {
          if(idBoard == activities[i].board_id){
            for (let j = 0; j < cf.length; j++) {
                if(cf[j].name == 'Días de desviación'){
                    axios.put(`https://api.trello.com/1/cards/${activities[i].act_card_id}/customField/${cf[j].id}/item${add}`, {value:{number: `${activities[i].act_day_desv}`}})
                    .then(resp => {
                    })
                    .catch(error =>[
                        //console.log(error)
                    ])
                }else if(cf[j].name == '% Desviación Plan vs Real'){
                    axios.put(`https://api.trello.com/1/cards/${activities[i].act_card_id}/customField/${cf[j].id}/item${add}`, {value:{number: `${activities[i].act_desv_percentage}`}})
                    .then(resp => {
                    })
                    .catch(error =>[
                        //console.log(error)
                    ])
                }else if(cf[j].name == 'HH Clockify'){
                    axios.put(`https://api.trello.com/1/cards/${activities[i].act_card_id}/customField/${cf[j].id}/item${add}`, {value:{number: `${activities[i].act_time_loaded}`}})
                    .then(resp => {
                    })
                    .catch(error =>[
                        //console.log(error)
                    ])
                }
               setTimeout(()=>{}, 1000)     
            }
          }
            
        }
    })
    .catch(error =>{
        //console.log(error)
    })
    setTimeout(()=>{}, 1000)
  })
    

    
}
async function updateDesvPercent2(){
  await pool.query("UPDATE `request` AS `dest`, (SELECT `x`.`req_id`,`x`.`desv_perc` FROM (SELECT `req_id`, ((SUM(`act_time_loaded`) / SUM(`act_estimated_hours`))*100)-100 AS `desv_perc` from `activities` where `act_title` = 'false' AND `act_time_loaded` != 0 GROUP BY `req_id`) AS `x` WHERE `x`.`desv_perc` > 0) AS `src` SET `dest`.`req_deviations_ptge` = ROUND(`src`.`desv_perc`) , `dest`.`req_day_desv` = DATEDIFF(`dest`.`req_real_final_date`,`dest`.`req_final_date`) WHERE `dest`.`req_id` = `src`.`req_id`;")
  return 0;
}
async function updateDesvPercent(){
    let time_loaded = []; let estimated_hours = [];  let status = []; let ids = [];
    let end_date = [];
    let real_end_date = [];
    let desvPert = [];
    let daysDesv = [];
    let temp = 0;

    // Guardamos los valores necesarios para el calculo respectivo
    const activities = await pool.query(`select * from activities where act_title = 'false' AND act_real_end_date IS NOT NULL AND act_init_real_date IS NOT NULL`)
    for (let i = 0; i < activities.length; i++) {
        time_loaded.push(activities[i].act_time_loaded)
        estimated_hours.push(activities[i].act_estimated_hours)
        ids.push(activities[i].act_id)
        status.push(activities[i].act_status)
        real_end_date.push(activities[i].act_real_end_date);
        end_date.push(activities[i].act_end_date);
    }

    // Se considera que si una actividad se encuentra con status "Active" entonces no ha sido completada
    // por lo tanto se considerara en los calculos de las desviaciones.
    let index = [];
    for (let i = 0; i < status.length; i++) {
        if (status[i] !== 'Active'){
            index.push(i)
        }
    }
    // Eliminamos los datos que no necesitamos (Actividades completadas)
    const indexSet = new Set(index)
    time_loaded = time_loaded.filter((value, i) => !indexSet.has(i));
    estimated_hours = estimated_hours.filter((value, i) => !indexSet.has(i));
    ids = ids.filter((value, i) => !indexSet.has(i));
    status = status.filter((value, i) => !indexSet.has(i));
    real_end_date = real_end_date.filter((value, i) => !indexSet.has(i));
    end_date = end_date.filter((value, i) => !indexSet.has(i));

    // Para cada una de las actividades no completadas
    for (let i = 0; i < ids.length; i++) {
        // Calculamos la desviacion 
        temp = ((time_loaded[i]/estimated_hours[i]) * 100)-100;
        //si el porcentaje es negativo, cargamos 0
        if (temp > 0) {
            desvPert.push(temp)
        } else {
            desvPert.push(0)
        }

        // Calculamos la desvicion en dias si y solo si la fecha in es menor a la fecha de hoy
        if (end_date[i] < real_end_date[i]){
            //daysDesv.push()
            // fecha actual - fecha vieja = dias diff
            let diffTime = Math.abs(real_end_date[i] - end_date[i]);
            let diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            daysDesv.push(diffDays)
        } else {
            daysDesv.push(0)
        }

        // Actualizamos las desviaciones respectivas en BD
        let updateValues = await pool.query(`UPDATE activities SET act_desv_percentage = ${desvPert[i]}, act_day_desv = ${daysDesv[i]} 
         WHERE act_id = ${ids[i]}`)


    }
    return 0;
}


function checkH(duration) {
    return duration.indexOf("H");
  }
  
  function checkM(duration) {
    return duration.indexOf("M");
  }
  
  function checkS(duration) {
    return duration.indexOf("S");
  }
  
  function updateTrelloCards(activities) {
    axios
      .get(
        `https://api.trello.com/1/boards/5ed18e8039bdeb21ec923c5e/customFields${add}`
      )
      .then((resp) => {
        cf = resp.data;
        camposP = {};
        for (let i = 0; i < activities.length; i++) {
          for (let j = 0; j < cf.length; j++) {
            if (cf[j].name == "HH Acumuladas") {
              axios
                .put(
                  `https://api.trello.com/1/cards/${activities[i].act_card_id}/customField/${cf[j].id}/item${add}`,
                  { value: { number: `${activities[i].act_time_loaded}` } }
                )
                .then((resp) => {
                })
                .catch((error) => {
                  //console.log(error)
                });
            }  else if (
              cf[j].name == "HH Clockify"
            ) {
              axios
                .put(
                  `https://api.trello.com/1/cards/${activities[i].act_card_id}/customField/${cf[j].id}/item${add}`,
                  { value: { number: `${activities[i].act_time_loaded}` } }
                )
                .then((resp) => {
                })
                .catch((error)  => {
                  //console.log(error)
                });
            }
          }
        }
      })
      .catch((error) => {
        //console.log(error);
      });
  }
  
  async function getMembersEmail() {
    
  activities = await pool.query("SELECT * FROM activities")
  const members = []
  const emails = []
  var tam = 0
  for (let i = 0; i < activities.length; i++) {
    await TrelloAxios.get(`/cards/${activities[i].act_card_id}${add}`)
    .then((resp)=>{
      data = resp.data
      
      if(data.idMembers[0] != '[]'){
        
        if(!members.includes(data.idMembers[0])){
          
          tam = members.length
          members[tam] = data.idMembers[0]
          
        }
      }
      
      
    })
    .catch(error=>{
      //console.log(error)
    })  
  }
  
  
    for (let j = 0; j < members.length; j++) {
      await TrelloAxios.get(`/members/${members[j]}`)
      .then(resp =>{
        
        data = resp.data
        
        if(data.email != null){
        tamaño = emails.length
        emails[tamaño] = data.email
        
        } 
      })
      .catch(error=>{
        //console.log(error)
      })
    }
  }
    
    
  

  function getUserID(email) {
    /*recibe parametro email, busca en la lista de usuarios, 
      devuelve el resultado filtrado y se retorna el ID en la funcion
      (si el email coincide en su totalidad es la posicion 0 en la lista)*/
    return new Promise(async (resolve, reject) => {
      try {
        const result = await ClockifyAxios.get(
          `/workspaces/${workspaceId}/users?email=${email}`
        );
          
        resolve(result.data[0].id);
      } catch (error) {
        reject(error);
      }
    });
  }
  
  function getProjectID(name, client) {
    /*recibe parametro name(nombre del proyecto) y client(nombre del cliente), busca en la lista de proyectos, 
      devuelve el resultado filtrado y se retorna el ID en la funcion
      (si los parametros coinciden en su totalidad es la posicion 0 en la lista)*/
    return new Promise(async (resolve, reject) => {
      try {
        const result = await axios.get(
          `/workspaces/${workspaceId}/projects?name=${name}&client=${client}`
        );
        resolve(result.data[0].id);
      } catch (error) {
        reject(error);
      }
    });
  }
  
  function getTaskID(name, projectId) {
    /*recibe parametro name(nombre de la tarea) y projectId(ID del proyecto), busca en la lista de tareas dentro del proyecto, 
      devuelve el resultado filtrado y se retorna el ID en la funcion
      (si los parametros coinciden en su totalidad es la posicion 0 en la lista)*/
    return new Promise(async (resolve, reject) => {
      try {
        const result = await axios.get(
          `/workspaces/${workspaceId}/projects/${projectId}/tasks?name=${name}`
        );
        resolve(result.data[0].id);
      } catch (error) {
        reject(error);
      }
    });
  }

module.exports = router
