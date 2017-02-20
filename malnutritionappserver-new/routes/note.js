var db = require("../database/db");
var Note = require("./../model/user.js");
var express = require('express')
var router = express.Router()

router.post('/add', function(req, res){
    var userId = req.body.userId;
    var authKey = req.body.authKey;
    var json = req.body.json;
    var creationTime = req.body.creationTime;
    db.users.authenticate(userId, authKey, function(user){
        var note = new Note({json: json, creationTime: creationTime});
        db.users.addNote(userId, note, function(){
            res.send({data: null, error: null});
        }, function(error){
            res.send({data: null, error: error});
        });
    });
});

module.exports = router;