var mongoose =  require('mongoose') ;

var signalements = mongoose.Schema({region : {type : String, required : true},
    ville : {type : String, required : true},
    quartier : {type : String, required : true},
    date : {type : Date, required : true},
    photo : {type : String, required : true}});



module.exports = mongoose.model('mballitsignalements', signalements);