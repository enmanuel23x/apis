//npm requires
const express = require('express')
const cors = require('cors')
const axios = require('axios')
const http = require('http')
const fs = require('fs');

//project's own requires
const PORT = process.env.PORT || 4090
const trello = require('./routes/trello')
const clockify = require('./routes/clockify')
const pool = require('./db/database');
//inizialitation
const app = express()

//middlewares
app.use(express.json())
app.use(cors())
app.use('/trello', trello)
app.use('/clockify', clockify)
app.get('/html',(req, res)=>{
  res.sendFile(__dirname+"/index.html")
})

/*let repeat = setInterval(getCard, 2000, '5ecc545f367f7d139208c139')
 function getCard(boardId) {
     axios.get(`/boards/${boardId}/cards${add}`)
     .then(function (resp) {
         //console.log(resp.data)
         var c = {}
         cardsX = resp.data
         //console.log(cardsX[0])
         for(var i = 0; i < cardsX.length; i++){
             console.log(i)
             //console.log(cardsX[i].id)
             c[i].id = cardsX[i].id
             c[i].desc = cardsX[i].desc
             c[i].name = cardsX[i].name
             c[i].idList = cardsX[i].idList
         }
         console.log(c[0])
      })
      .catch(function (error) {
        console.log('Error ' + error.message)
      })
            

}*/

//server
app.set('port', PORT);
var server = http.createServer(app)
server.listen(PORT, () => console.log(`La magia pasa en localhost:${PORT}`));