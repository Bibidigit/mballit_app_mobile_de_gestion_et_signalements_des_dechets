var mongoose = require('mongoose') ;


var utilisateurs = mongoose.Schema({pseudo : {type:String, required : true},
    telephone : {type: String, required : true},
    codePIN : {type : String, required : true}});


module.exports = mongoose.model('mballitusers', utilisateurs);