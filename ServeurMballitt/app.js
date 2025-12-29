var express = require('express');

var cors = require ('cors');

var app = express () ;

app.use (cors () );



var utilisateurs = [

{pseudo : 'user000000000000000' , telephonenumber : '7XXXXXXXX' , codePIN : '000000'},

 ]
 
 
var callback = function (request, reponse) {


reponse.json(utilisateurs) ;

console.log (utilisateurs);

} ;

app.get ('/', function(request, reponse){

reponse.send('Bienvenue : serveur/API') ;
console.log('API pour MbaLLit |||') ;
}) ;
app.get ('/utilisateurs', callback);


app.use (express.json ());
var callback2 = function (request, reponse)
{
	var user = {pseudo : request.body.pseudo, telephonenumber : request.body.telephonenumber, codePIN : request.body.codePIN} ;
	utilisateurs.push (user);
	reponse.json (user);
	console.log (user);

};
app.post('/utilisateurs', callback2);

/*var callback3 = function(request, reponse)
{
	var signalements = [{region : 'Nowhere', ville : 'Nowhere', quartier : 'Nowhere', dateandtime : 'No_time', description : 'No_description' }] ;
	reponse.json (signalements);

};
*/

var signalements = [{region : 'Nowhere', 
	ville : 'Nowhere', 
	quartier : 'Nowhere', 
	dateandtime : 'No_time', 
	description : 'No_description' }] ;

app.get('/utilisateurs/:telephonenumber', function(request, reponse)
{
	
	let numb = request.params.telephonenumber ; 
		

		reponse.json ({
		
		numerouser : numb ,
		newsignal : signalements ,
	});
	
	
	
	//console.log (signalements) ;

}) ;


app.post ( '/utilisateurs/:telephonenumber', function (request, reponse)
{
	var signal = {region : request.body.region, ville : request.body.ville, quartier : request.body.quartier, dateandtime : request.body.dateandtime, description : request.body.descriptions}

	signalements.push (signal);
	var numbertel = request.params.telephonenumber ;
	reponse.json ({
		
		numerouser : numbertel ,
		newsignal : signal ,
	});
	
	
	console.log (signal) ;


});

app.use (function (request, reponse)
{
	reponse.status(404).send("Erreur") ;
	console.log ("Une erreur s'est produite !") ;

}) ;

app.listen (1144, "0.0.0.0",() => console.log ("L'API écoute sur le port 1144"));
