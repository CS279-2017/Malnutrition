var db = require("../database/db");
var User = require("./../model/user.js");

var express = require('express')
var router = express.Router()

const crypto = require('crypto');
const secret = 'nutririskisawesome';

router.post('/login', function(req, res){
    var email = req.body.email;
    var password = req.body.password;
    db.users.login(email, password, function(object){
        var authKey = object.authKey;
        var userId = object.userId;
        res.send({data: {authKey: authKey, userId: userId}, error: null});
    }, function(error){
        res.send({data: null, error: error});
    })
})

router.post('/register', function(req, res){
    console.log("/register_mobile called!");
    var email = req.body.email;
    var password = req.body.password;

    function error_handler(error){
        res.send({data: null, error: error})
    }
    db.registration.registerEmail(email, function(){
        console.log("register mobile completed!");
        var user = new User(email, password);
        db.users.add(user, function(){
            res.send({data: null, error: null});
        }, error_handler);
    }, error_handler);
});

router.get('/register_verification_code', function(req, res){
    console.log("register verification code called!");
    var email = req.param("email");
    var verification_code = req.param("code");
    db.registration.registerVerificationCode(verification_code, email, function(){
        db.users.update({email: email}, {$set: {verified: true}}, function(){
            res.send("Your account " + email + " has been verified! You can now login via the NutriRisk app");
        }, function(error){
            res.send("An error occured");
        })
    }, function(error){
        res.send("Invalid verification code");
    })
})

router.post('/reset_password', function(req, res){
    console.log("reset password called!");
    var email = req.param("email");
    var password = req.param("password")
    function error_handler(error){
        res.send({data: null, error: error})
    }
    db.registration.resetPasswordEmail(email, function(){
        db.users.update({email: email}, {$set: {newPassword: password}}, function(){
            res.send({data: null, error: null});
        }, error_handler)
    }, error_handler)
});

router.get('/reset_password_verification', function(req, res){
    console.log("register password email called!");
    var email = req.param("email");
    var verification_code = req.param("verification_code");

    function error_handler(error){
        res.send("An error occured");
    }

    db.registration.resetPasswordVerificationCode(verification_code, email, function() {
        db.users.getEmail(email, function (user) {
            db.users.add({email: user.email, password: user.newPassword, newPassword: null}, function () {
                res.send("Your account " + email + " has been verified! You can now login via the NutriRisk app");
            });
        }, error_handler)
    }, error_handler);
})

router.post('/authenticate', function(req, res) {
    console.log("authenticate called!")
    // var username = req.body.username,
    var userId = req.body.userId;
    var authKey = req.body.authKey;
    db.users.authenticate(authKey, userId, function(){
        console.log("authentication successful!")
        res.send({data: null, error: null})
    }, function(error){
        console.log("invalid auth key!")
        res.send({data: null, error: error});
    });
});

module.exports = router
