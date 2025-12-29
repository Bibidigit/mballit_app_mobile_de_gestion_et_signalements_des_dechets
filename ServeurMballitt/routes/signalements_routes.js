var express = require('express') ;
const { chargerlessignalements, ajouterunsignalement } = require('../controllers/signalements_controllers');

var routersignals = express.Router ();

routersignals.get('/utilisateurs/:tel', chargerlessignalements) ;
routersignals.post('/utilsateurs/:tel', ajouterunsignalement);
