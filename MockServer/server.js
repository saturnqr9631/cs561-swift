
const express = require('express');

const app = express();

var port = 7878

var path = require('path')
var bodyParser = require('body-parser')

app.use(express.static(path.join(__dirname, 'build')));

var dataController = require('./dataController');


// API route:
app.get('/data/2.5/weather', dataController.getData);

app.listen(port, () => {
  console.log('The mock server is listening for request on port ' + port);
});
