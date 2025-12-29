var express = require('express');
const { chargerlesutilisateurs, ajouterunutilisateurs } = require('../controllers/users_controllers');

var routeruser = express.Router ();


routeruser.get ('/utilisateurs', chargerlesutilisateurs);
routeruser.post ('/utilisateurs', ajouterunutilisateurs);

