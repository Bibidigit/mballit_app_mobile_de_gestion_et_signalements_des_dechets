

var Signals = require('../models/signalements_model');


exports.chargerlessignalements = async (request, reponse) => {
    var signals = await Signals.find ();
    reponse.json (signals);
};

exports.ajouterunsignalement = async (request, reponse) => {
    var signals =  new Signals(request.body);
    await Signals.save(signals);
    reponse.json(request.body);

};