/* PARA CORREGIR 

- falta req_id en tabla activities
- varias columnas nulas en la tabla request

*/
//npm requires
const express = require('express');
const axios = require('axios');
const delay = require('delay');
const pool = require('../db/database');
const { response } = require('express');
//initializations
const router = express.Router()
const TrelloAxios = axios.create({
    baseURL: 'https://api.trello.com/1'
});
const backend = axios.create({
  baseURL: 'http://10.48.13.156:4090'
});
TrelloAxios.defaults.headers.post['Content-Type'] = 'application/json';
const add = '?key=97ed379704c2ca46cc6de86a6f0fa31f&token=dab44b231906a2484ee48d2fe11704046651e0083c6e71da3727f33589abd728';
//'?key=97ed379704c2ca46cc6de86a6f0fa31f&token=dab44b231906a2484ee48d2fe11704046651e0083c6e71da3727f33589abd728';
//'?key=5d94aa42b86a6f4e11d7cd857ff8699a&token=22b262d7b19e02d785a2b1fa0ba982e55ab891122b07d7ff79ffda934f7a4e28';

//routes
/**
 * Devuelve todos los tableros
 */
router.get('/getBoards', async (req, res) => {
    boards = await getBoards();
    res.json({boards})
});
router.get('/syncro', async (req, res) => {
  backend.get(`/trello/getCards`)
    .then((response)=>{
      console.log(response.data)
      backend.get(`/clockify/getTime`)
        .then((response2)=>{
      console.log(response2.data)
          backend.get(`/clockify/actualizar`)
            .then((response3)=>{
              console.log("final")
              res.send(response3.data)
          });
      });
    });
  
});

router.get('/createCards', async (req,res)=>{
  const cardsToCreate = await pool.query(`SELECT * FROM activities LEFT JOIN request ON activities.req_id = request.req_id WHERE activities.act_card_id IS NULL AND activities.act_title = 'false' ORDER BY activities.act_init_date`)
  let boardIds = cardsToCreate.map(board => board.board_id)
  let boardIdsFiltered = []
  boardIds.forEach((boardId, i)=>{
    if(!boardIdsFiltered.includes(boardId)){
      boardIdsFiltered[i] = boardId
    }
  })
  boardIdsFiltered.forEach(async(boardId,i) =>{
    list = await createList(boardId, 'Por Iniciar')
    if(i == 0){
      const data = await createCustomFields(boardId)
    }
    
    cardsToCreate.forEach(async (card,i) =>{
      
      if(card.board_id == boardId){
        data = await createCard(card, list.id)
      }
      await delay(7000);
    })
  })
  
  res.send('listo')

})
/**
 * Devuelve todas las tarjetas
 */
router.get('/getCards', async (req, res) => {
        const boards = await pool.query(`SELECT * FROM request WHERE sta_id = 'open'`)
        let cards = [], lists = [], initList = [], endList = [], valtList = [], end = 0;
        let cont = 0, cont2 = 0, count = 0;
        boards.forEach(async (board, i) => {
          lists[i] = (await TrelloAxios.get(`/boards/${board.board_id}/lists${add}`)).data;
          initList[i] = lists[i].filter( (el) => el.name.toUpperCase() == "Por Iniciar".toUpperCase() )[0].id;
          endList[i] = lists[i].filter( (el) => el.name.toUpperCase() == "Finalizadas".toUpperCase() )[0].id;
          valtList[i] = lists[i].filter( (el) => el.name.toUpperCase() == "Validadas".toUpperCase() )[0].id;
            cards[i] = await getCards(board.board_id);
            count += cards[i].length
            cont2++;
            Array.from(cards[i]).forEach(async (card) => {
              await delay(7000);
                customFields = await getCustomFieldsInCard(card.id)
                cflength = customFields.length
                    if(customFields[6]!= undefined && customFields[5]!= undefined && customFields[4]!= undefined && customFields[3]!= undefined 
                      && customFields[2]!= undefined && customFields[1]!= undefined && customFields[0]!= undefined){
                    const req_id = board.req_id
                    const act_init_date = formatDateTime(customFields[6].value.date)
                    const act_init_real_date = formatDateTime(customFields[5].value.date)
                    const act_real_end_date = formatDateTime(customFields[4].value.date)
                    const estimated_hours = customFields[3].value.number
                    const act_end_date = formatDateTime(card.due)
                    const act_desv_percentage = customFields[1].value.number
                    const act_day_desv = customFields[0].value.number
                    const act_time_loaded = customFields[2].value.number
                    await delay(7000);
                    const act_porcent = await calculatePorcent(card.id)
                    const exist = await pool.query(`SELECT * FROM activities WHERE act_trello_name = '${card.name}'`)
                    end = 0;
                    if(card.idList != initList[i] && card.idList != endList[i]){
                      end = 1;
                    }else if(card.idList == endList[i]){
                      await TrelloAxios.put(`/cards/${card.id}/${add}&idList=${valtList}`)
                      end = 2;
                    }else if(card.idList == valtList[i]){
                      end = 3;
                    }
                    if(exist.length <= 0){
                        try{
                            const requestx = await pool.query(`INSERT INTO activities (req_id, act_trello_name, act_description_trello, act_card_id, act_init_date, act_init_real_date, act_end_date, act_real_end_date, act_estimated_hours, act_time_loaded , act_desv_percentage,act_day_desv, act_porcent, act_card_end) VALUES ('${req_id}','${card.name}', '${card.desc}', '${card.id}', '${act_init_date}', '${act_init_real_date}', '${act_end_date}', '${act_real_end_date}', '${estimated_hours}','${act_time_loaded}' ,'${act_desv_percentage}','${act_day_desv}', '${act_porcent}', '${end}')`)
                        } catch (error){
                            //console.log(error)
                        }
                    }else{
                      const requestx = await pool.query(`UPDATE activities SET act_init_real_date='${act_init_real_date}',act_real_end_date='${act_real_end_date}', act_porcent='${act_porcent}', act_card_end = '${end}' WHERE act_trello_name ='${card.name}' `)
                    }
                  } 
                  await delay(7000);
                  cont++;
                  if(boards.length == cont2 && count == cont){
                   res.send("listo ")
                  }
            })
             await delay(7000);
             
        }); 
        
});

/**
 * Actualiza tarjeta
 * Formato de fecha (aaaa-mm-dd)
 */
router.post('/updateCard', async (req, res) => {
    const { id_card, new_name, new_desc, closed, new_pos, expires_in } = req.body;
    const updated_card = await updateCard(new_name, new_desc, expires_in, closed, new_pos);
    res.json({
        updated_card
    })
});

/**
 * Devuelve todos los campos personalizados que se han creado, nombre y id
 */
router.post('/getCustomFields', async (req, res) => {
    const { id_board } = req.body;
    cf = await getAllCustomFields(id_board);
    res.json({
        cf
    });
});

/**
 * Devuelve Items de Campos Personalizados, valores y id si están vacios, no los devuelve
*/
router.post('/getCustomFieldItemsCard', async (req, res) => {
    const {id_card} = req.body
    cf =  await getCustomFieldsInCard(id_card)
    res.json({
            cf
    })
})

/**
 * Devuelve el item del campo personalizado que pertenezca a el id_item de aquí obtengo el valor del campo
 */
router.post('/getCustomFieldItemCard', async (req, res) => {
    const {id_card, id_item} = req.body
    cf = await getCustomFieldItemCard(id_card, id_item);
    res.json({
        cf
    })
})

/**
 * Actualizar campo personalizado tipo fecha
 */
router.post('/updateCustomFieldCardDate', async (req, res) => {
    const { new_date, id_card, idCustomField } = req.body
    updated_card = await updateCustomFieldCardDate(id_card, idCustomField, new_date);
    res.json({
        updated_card
    })
})

/**
 * Actualizar campo personalizado tipo texto
 */
router.post('/updateCustomFieldCardText', async (req, res) => {
    const { new_text, id_card, idCustomField } = req.body
    await delay(3000);
    updated_card = await updateCustomFieldCardText(id_card, idCustomField, new_text)
    res.json({
        updated_card
    })
})

/**
 * Actualizar campo personalizado tipo number
 */
router.post('/updateCustomFieldCardNumber', async (req, res) => {
    const { new_number, id_card, idCustomField } = req.body
    await delay(3000);
    updated_card = await updateCustomFieldCardNumber(id_card, idCustomField, new_number)
    res.json({
        updated_card
    })
})

/**
 * Agrega PU campos personalizados al tablero especificado
 */
router.post('/addCustomFieldsPU', async (req, res) => {
    const { id_board } = req.body
    data = await addCustomFieldsPU(id_board)
    res.json({
        data
    })
})

/**
 * Añade campo personalizado a tablero
 */
router.post('/addCustomFieldBoard', async (req, res) => {
    const { id_board, name, type, options, display_cardFront } = req.body
    data = await addCustomFieldBoard(id_board, name, type, options, display_cardFront)
    res.json({
        data
    })
})

/**
 * Elimina campo personalizado
 */
router.post('/deleteCustomFieldBoard', async (req, res) => {
    const { id_custom_field } = req.body
    data = await deleteCustomFieldBoard(id_custom_field) 
    res.json({
        data
    })

})

/**
 * Actualiza campo personalizado en tablero
 */
router.post('/updateCustomFieldBoard', async (req, res) => {
    const { id_custom_field, new_name, display_cardFront } = req.body
    data = await updateCustomFieldBoard(id_custom_field, new_name, display_cardFront)
    res.json({
        data
    })
})

/**
 * Trae lista de todas checklist en una tarjeta
 */
router.post('/getCheckListCard', async (req, res) => {
    const { id_card } = req.body
    data = await getCheckListCard(id_card) 
    res.json({
        data
    })
})

/**
 * Agregar checklist a una tarjeta
 */
router.post('/addCheckList', async (req, res) => {
    const { id_card, new_name, pos } = req.body
    data = await addCheckList(id_card, new_name, pos) 
    res.json({
        data
    })
})

/**
 * Agregar items to checklist
 */
router.post('/addItemsToCheckList', async (req, res) => {
    const { id_check_list, new_name, pos, checked } = req.body
    data = await addItemsToCheckList(id_check_list, new_name, pos, checked);
    res.json({
        data
    })
})

router.post('/updateItemInCheckList', async (req, res) => {
    const { id_check_list, pos, id_check_item, id_card, name, state } = req.body
    data = await updateItemInCheckList(id_card ,id_check_list, id_check_item, pos, name, state)
    res.json({
        data
    })
})

router.post('/deleteItemInCheckList', async (req, res) => {
    const { id_check_list, pos, id_check_item, new_name, checked } = req.body
    data = await deleteItemInCheckList(id_check_list, id_check_item, pos, new_name, checked)
    res.json({
        data
    })
})





//Funciones
function formatDateTime(dateTime) {
    splitx = dateTime.split('.')
    lastSplit = splitx[0].split('T')
    date = lastSplit[0]
    time = lastSplit[1]
    total = date + ' ' + time
    return total
}
function getBoards() {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.get(`/members/me/boards${add}`);
          result.data.forEach(async (data) =>{
            const exists = await pool.query(`SELECT * FROM request WHERE board_id = '${data.id}'`)
            if( exists.length > 0){
              const isClosed = data.closed ? status='closed' : status='open'
              const request = await pool.query(`UPDATE request SET req_title = '${data.name}', sta_id = '${isClosed}' WHERE board_id  = '${data.id}'`);
            }else{
              const isClosed = data.closed ? status='closed' : status='open'
              const request = await pool.query(`INSERT INTO request (board_id, req_title, sta_id) VALUES ('${data.id}', '${data.name}', '${isClosed}')`);
            }
             
          });
          resolve(result.data)
        } catch (error) {
            //console.log(error)
          reject(error)
        }
      });
}
function getCards(id_board) {
    return new Promise(async (resolve,reject) => {
        try {
          await delay(7000);
          const result = await TrelloAxios.get(`/boards/${id_board}/cards${add}`);
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function createCustomFields(boardId) {
  return new Promise(async (resolve,reject) => {
      try {
        async function createCustomFieldsprocess(resolve){
          const result = await TrelloAxios.post(`/customField${add}`, {"idModel":boardId,
        "modelType": "board",
        "name": "Fecha de inicio planificada",
        "type":"date"});
        await delay(7000);
        const result2 = await TrelloAxios.post(`/customField${add}`, {"idModel":boardId,
        "modelType": "board",
        "name": "Fecha de inicio real",
        "type":"date"});
        await delay(7000);
        const result3 = await TrelloAxios.post(`/customField${add}`, {"idModel":boardId,
        "modelType": "board",
        "name": "Fecha fin estimada/real",
        "type":"date"});
        await delay(7000);
        const result4 = await TrelloAxios.post(`/customField${add}`, {"idModel":boardId,
        "modelType": "board",
        "name": "HH Estimadas",
        "type":"number"});
        await delay(7000);
        const result6 = await TrelloAxios.post(`/customField${add}`, {"idModel":boardId,
        "modelType": "board",
        "name": "HH Clockify",
        "type":"number"});
        await delay(7000);
        const result7 = await TrelloAxios.post(`/customField${add}`, {"idModel":boardId,
        "modelType": "board",
        "name": "% Desviación Plan vs Real",
        "type":"number"});
        await delay(7000);
        const result8 = await TrelloAxios.post(`/customField${add}`, {"idModel":boardId,
        "modelType": "board",
        "name": "Días de desviación",
        "type":"number"});
        await delay(7000);
        resolve(result8.data)
        }
        setTimeout( function(){ createCustomFieldsprocess(resolve); }, 2000);
      } catch (error) {
        reject(error)
      }
    });
}

async function calculatePorcent(cardID) {
  return new Promise(async (resolve,reject) => {
    try {
      await delay(7000);
  const result = await TrelloAxios.get(`/cards/${cardID}/checklists${add}`)
  let checklist = result.data[0]
  let checkItems = checklist.checkItems
  let length = checkItems.length
  let completed = 0
  let icompleted = 0
  let percentage = 0
  checkItems.forEach(c =>{
    c.state == 'complete' ? completed+=1 : icompleted+=1
  })
  completed == 0 ? percentage = 0 : percentage = (completed/length)*100
  resolve(percentage)
        } catch (error) {
          reject(error)
        }
      });
}
function createList(boardId, name) {
  return new Promise(async (resolve,reject) => {
      try {
        async function createListprocess(resolve){
          TrelloAxios.post(`/boards/${boardId}/lists${add}`, {"name": name })
          .then ( (response) =>{
            //console.log(response)
            resolve(response.data)
          }).catch( err => {
            //console.log(err)
            resolve(err)
          })
        }
        setTimeout( function(){ createListprocess(resolve); }, 2000);
      } catch (error) {
        reject(error)
      }
    });
}

function createCard(card, listId) {
  return new Promise(async (resolve,reject) => {
      try {
        async function createCardprocess(resolve){
          const result = await TrelloAxios.post(`/card${add}`, {"name": card.act_trello_name,"idList": listId, "desc": card.act_description_trello, "due": card.act_end_date});
        const updateCard = await pool.query(`UPDATE activities SET act_card_id = '${result.data.id}' WHERE act_trello_name = '${card.act_trello_name}'`)
        await delay(7000);
        await updateCustomFields(card.board_id, card, result.data.id)
        await delay(7000);
        await addMember(card, result.data.id)
        resolve(result.data)
        }
        setTimeout( function(){ createCardprocess(resolve); }, 2000);
      } catch (error) {
        reject(error)
      }
    });
}

async function addMember(card, cardId){
  return new Promise(async (resolve,reject) => {
      try {
        const result = await TrelloAxios.get(`/members/${card.act_trello_user}${add}`);
        const memberId = result.data.id
        await delay(4000);
        const result1 = await TrelloAxios.post(`/card/${cardId}/idMembers${add}`, {"value": memberId});
        resolve(result1.data)
      } catch (error) {
        reject(error)
      }
    });
}

async function updateCustomFields(idBoard, card, cardID) {
  axios.get(`https://api.trello.com/1/boards/${idBoard}/customFields${add}`)
  .then(async resp =>{
      cf = resp.data
      camposP = {}
          for (let j = 0; j < cf.length; j++) {
            await delay(7000);
              if(cf[j].name == 'Días de desviación'){
                  axios.put(`https://api.trello.com/1/cards/${cardID}/customField/${cf[j].id}/item${add}`, {value:{number: '0'}})
                  .then(resp => {
                  })
                  .catch(error =>[
                      //console.log(error)
                  ])
              }else if(cf[j].name == '% Desviación Plan vs Real'){
                  axios.put(`https://api.trello.com/1/cards/${cardID}/customField/${cf[j].id}/item${add}`, {value:{number: '0'}})
                  .then(resp => {
                  })
                  .catch(error =>[
                      //console.log(error)
                  ])
              }else if(cf[j].name == 'HH Clockify'){
                  axios.put(`https://api.trello.com/1/cards/${cardID}/customField/${cf[j].id}/item${add}`, {value:{number: `${card.act_time_loaded}`}})
                  .then(resp => {
                  })
                  .catch(error =>[
                      //console.log(error)
                  ])
              }else if(cf[j].name == 'Fecha de inicio planificada'){
            split = card.act_init_date
            axios.put(`https://api.trello.com/1/cards/${cardID}/customField/${cf[j].id}/item${add}`, {value:{date: `${split}`}})
            .then(resp => {
            })
            .catch(error =>[
                //console.log(error)
            ])
        }else if(cf[j].name == 'HH Estimadas'){
          axios.put(`https://api.trello.com/1/cards/${cardID}/customField/${cf[j].id}/item${add}`, {value:{number: `${card.act_estimated_hours}`}})
          .then(resp => {
          })
          .catch(error =>[
              //console.log(error)
          ])
      } 
                  
          
          
      }
  })
  .catch(error =>{
      //console.log(error)
  })

  
}



function getCustomFieldsInCard(cardID) {
    return new Promise(async (resolve,reject) => {
        try {
          await delay(7000);
          const result = await TrelloAxios.get(`/cards/${cardID}/customFieldItems${add}`);
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function updateCard(new_name, new_desc, expires_in, closed, new_pos) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.put(`/card/${id_card}${add}`, {"name": new_name, "desc": new_desc, "due": expires_in, "closed": closed, "pos": new_pos});
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function getAllCustomFields(id_board) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.get(`/boards/${id_board}/customFields${add}`);
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function getCustomFieldItemCard(id_card, id_item) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.get(`/cards/${id_card}/customFieldItems/${id_item}${add}`);
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function updateCustomFieldCardDate(id_card, idCustomField, new_date) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.put(`/cards/${id_card}/customField/${idCustomField}/item${add}`, {"value":{"date": new_date}});
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function updateCustomFieldCardText(id_card, idCustomField, new_text) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.put(`/cards/${id_card}/customField/${idCustomField}/item${add}`, {"value":{"text": new_text}});
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function updateCustomFieldCardNumber(id_card, idCustomField, new_number) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.put(`/cards/${id_card}/customField/${idCustomField}/item${add}`, {"number": new_number});
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function addCustomFieldsPU(id_board) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.post(`/boards/${id_board}/boardPlugins${add}`, {"idPlugin" : "56d5e249a98895a9797bebb9"});
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function addCustomFieldBoard(id_board, name, type, options, display_cardFront) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.post(`/customFields${add}`, {
            "idModel":id_board, //id_board
            "modelType": "board",
            "name": name,
            "type":type,
            "options": options,
            "display": {"cardFront":display_cardFront}
        });
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function deleteCustomFieldBoard(id_custom_field) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.delete(`/customFields/${id_custom_field}${add}`);
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function updateCustomFieldBoard(id_custom_field, new_name, display_cardFront) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.put(`/customFields/${id_custom_field}${add}`, {"name": new_name, "display": {"cardFront":display_cardFront}});
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function getCheckListCard(id_card) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.get(`/cards/${id_card}/checklists${add}`);
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function addCheckList(id_card, new_name, pos) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.post(`/checklists${add}`, {"idCard": id_card, "name": new_name, "pos": pos});
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function addItemsToCheckList(id_check_list, new_name, pos, checked) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.post(`/checklists/${id_check_list}/checkItems${add}`, {"name": new_name, "pos": pos, "checked": checked});
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function updateItemInCheckList(id_card ,id_check_list, id_check_item, pos, name, state) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.put(`/cards/${id_card}/checklist/${id_check_list}/checkItem/${id_check_item}${add}`, {"pos": pos, "name": name, "state": state})
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}
function deleteItemInCheckList(id_check_list, id_check_item, pos, new_name, checked) {
    return new Promise(async (resolve,reject) => {
        try {
          const result = await TrelloAxios.delete(`/checklists/${id_check_list}/checkItems/${id_check_item}${add}`, {"pos": pos, "name": new_name, "checked":checked})
          resolve(result.data)
        } catch (error) {
          reject(error)
        }
      });
}

router.get('/udppert', (req, res) => {
    updateDesvPercent()
    //updateRequest();
})

async function updateDesvPercent(){
    let time_loaded = []; let estimated_hours = [];  let act_status = []; let ids = [];
    let end_date = [];

    let desvPert = [];
    let daysDesv = [];


    // Guardamos los valores necesarios para el calculo respectivo
    const activities = await pool.query(`select * from dbgestion.activities`)
    for (let i = 0; i < activities.length; i++) {
        time_loaded.push(card.act_time_loaded)
        estimated_hours.push(card.act_estimated_hours)
        ids.push(card.act_id)
        act_status.push(card.act_status)
        end_date.push(card.act_end_date);
    }

    // Se considera que si una actividad se encuentra con status "Active" entonces no ha sido completada
    // por lo tanto se considerara en los calculos de las desviaciones.
    let index = [];
    for (let i = 0; i < act_status.length; i++) {
        if (act_status[i] !== 'Active'){
            index.push(i)
        }
    }
    // Eliminamos los datos que no necesitamos (Actividades completadas)
    const indexSet = new Set(index)
    time_loaded = time_loaded.filter((value, i) => !indexSet.has(i));
    estimated_hours = estimated_hours.filter((value, i) => !indexSet.has(i));
    ids = ids.filter((value, i) => !indexSet.has(i));
    act_status = act_status.filter((value, i) => !indexSet.has(i));
    end_date = end_date.filter((value, i) => !indexSet.has(i));

    // Objeto para obtener la fecha de hoy
    let today = new Date()
    let date = today;

    // Para cada una de las actividades no completadas
    for (let i = 0; i < ids.length; i++) {
        // Calculamos la desviacion si y solo si el tiempo cargado es mayor al tiempo estimado
        // En caso contrario asignamos 0
        if (time_loaded[i] > estimated_hours[i]) {
            desvPert.push((estimated_hours[i]/time_loaded[i]) * 100)
        } else {
            desvPert.push(0)
        }

        // Calculamos la desvicion en dias si y solo si la fecha in es menor a la fecha de hoy
        if (end_date[i] < date){
            //daysDesv.push()
            // fecha actual - fecha vieja = dias diff
            let diffTime = Math.abs(date - end_date[i]);
            let diffDays = Math.ceil(diffTime / (6000 * 60 * 60 * 24));
            daysDesv.push(diffDays)
        } else {
            daysDesv.push(0)
        }

        // Actualizamos las desviaciones respectivas en BD
        let updateValues = await pool.query(`UPDATE activities SET act_desv_percentage = ${desvPert[i]}, act_day_desv = ${daysDesv[i]} 
         WHERE act_id = ${ids[i]}`)
    }

}


async function updateRequest(){
    let reqIds = [];
    let finalDates = [];

    let today = new Date()
    let date = today;

    // Obtencion de los datos necesarios en la tabla request
    const request = await pool.query(`select req_id, req_final_date from dbgestion.request`)
    for (let i = 0; i < request.length; i++) {
        reqIds.push(request[i].req_id)
        finalDates.push(request[i].req_final_date)
    }

    const ids = new Set(reqIds)
    reqIds = Array.from(ids)

    let estimated = [];
    let loaded = [];

    // Se ejecuta el comando para sumar todas las horas estimadas y cargadas segun el id de la solicitud
    for (let i = 0; i < reqIds.length; i++) {
        let querySumEstimated = await pool.query(`SELECT SUM(act_estimated_hours) as sum_estimated FROM activities WHERE req_id = ${reqIds[i]}`)
        let querySumLoaded = await pool.query(`SELECT SUM(act_time_loaded) as sum_loaded FROM activities WHERE req_id = ${reqIds[i]}`)
        estimated.push(querySumEstimated[0].sum_estimated)
        loaded.push(querySumLoaded[0].sum_loaded)
    }

    let deviations = [];
    let daysDesv = [];
    // Calculo de las desviaciones para cada una de las solicitudes
    for (let i = 0; i < estimated.length; i++) {
        if (loaded[i] > estimated[i]){
            deviations.push((estimated[i]/loaded[i]) * 100)
        } else {
            deviations.push(0)
        }
        // Se actualiza el campo de desviacion en base al resultado obtenido
        let updateDeviations = await pool.query(`UPDATE request SET req_deviations_ptge = ${deviations[i]} WHERE req_id = ${reqIds[i]}`)

        // Se obtiene la diferencia en dias de ser el caso, si no 0
        if (finalDates[i] < date){
            // fecha actual - fecha vieja = dias diff
            let diffTime = Math.abs(date - finalDates[i]);
            let diffDays = Math.ceil(diffTime / (6000 * 60 * 60 * 24));
            daysDesv.push(diffDays)
        } else {
            daysDesv.push(0)
        }
        // Se actualiza el campo de desviacion en base al resultado obtenido
        let updateDaysDesv = await pool.query(`UPDATE request SET req_day_desv = ${daysDesv[i]} WHERE req_id = ${reqIds[i]}`)
    }


}


// Funcion para actualizar a las 12 AM
async function fillAllData(){
  result = await backend.get('/trello/syncro');
}
const interval_long =  60*60*1000;//1 hora
async function timer(interval_long){
  const date = (new Date(new Date().toLocaleString("en-US", {timeZone: "America/Caracas"}))).getHours(); // Create a Date object to find out what time it is
    if(date < 13 || date < 19 ){ // Check the time at 12:00PM - 01:00PM OR 06:00PM - 07:00PM
      await fillAllData()
  }
  setTimeout(function(){ timer(interval_long); }, interval_long);//Renew timer
}
timer(interval_long)

module.exports = router
