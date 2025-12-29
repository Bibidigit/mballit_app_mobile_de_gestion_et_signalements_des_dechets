var mongoose = require("mongoose");

mongoose.connect('mongodb://localhost:27017') ;

var express  = require('express');
var app = express () ;
var appusers =  require('./routes/users_routes');
var appuserssignals =  require('./routes/users_routes');
app.use (express.json());

app.use('/api', () => {appusers}) ;
app.use('/api', () => appuserssignals) ;

app.listen (1144,() => console.log ("L'API écoute sur le port 1144"));