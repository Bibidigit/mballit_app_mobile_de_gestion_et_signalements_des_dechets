
const users_model = require('../models/signalements_model');



exports.chargerlesutilisateurs = async (request, reponse) => {
    var users = await users_model.find () ;
    reponse.json(users);
};

exports.ajouterunutilisateurs = async (request, reponse) => {
    var newuser = new users_model(request.body);
    await users_model.save(newuser) ;
    reponse.json(request.body);
}