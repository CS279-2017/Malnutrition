var express = require('express');
var router = express.Router()
var bte = require('../bte/bte');
var db = require('../db/db')
const util = require('./../util/util');
var User = require("./../model/user.js");

var i18n = require('i18n');


router.get('/', function(req, res){
    console.log("GET /reset-password called");
    bte.render('/reset-password/index.html', function(html){
        res.send(html);
    }, {cookies: req.cookies, locale: req});
});

router.post('/', function(req, res){
    console.log('POST /reset-password called!')
    var email = req.body.email

    res.type('json')
    //make sure valid email and password
    var validateEmail = util.validateEmail(email);
    if(!validateEmail.success){
        res.send({data: null, error: req.__(validateEmail.errorMessage)});
        return;
    }

    function errorHandler(error){
        res.send({data: null, error: req.__(error)});
    }

    db.registration.resetPassword(email, function(){
        res.send({data: {email: email}, error: null});
    }, errorHandler, req);
})

router.get('/change', function(req, res){
    var email = req.param("email");
    var code = req.param("code");
    db.registration.resetPasswordVerify(code, email, function(){
        bte.render('/reset-password/change.html', function(html){
            //add the email and code to the form as hidden variables
            var content =
                '$("#change-password-form").prepend('+ "\'" +
                '  <input type="hidden" name="email" value="' + email+ '">'+
                '  <input type="hidden" name="code" value="' + code + '">'+
                "\'" + ');';
            var javascript =  '<script>' + content + '</script>';
            res.send(html + javascript);
        }, {cookies: req.cookies, locale: req});
    }, function(error){
        //add a alert about how the verification code was incorrect
        bte.render('/reset-password/index.html', function(html){
            html = html + failure(error, req);
            res.send(html);
        }, {cookies: req.cookies, locale: req});
    })
    
});

router.post('/change', function(req, res){
    console.log('/reset-password/change called!')
    var email = req.body.email
    var code = req.body.code
    var password = req.body.password

    console.log("email: " + email);
    console.log("code: " + code);
    console.log("password: " + password);

    res.type('json')

    //validate password
    var validatePassword = util.validatePassword(password);
    if(!validatePassword.success){
        res.send({data: null, error: req.__(validatePassword.errorMessage)});
        return;
    }
    password = util.hashPassword(password);

    function errorHandler(error){
        res.send({data: null, error: req.__(error)});
        return;
    }

    db.registration.resetPasswordChange(code, email, function(){
        console.log("resetPasswordChange completed");
        //call some function to reset the password
        db.users.updateOne({email: email}, {$set: {password: password}}, function(nModified){
            res.send({data: {email: email, code: code}, error: null})
        }, errorHandler)
    }, errorHandler)
})


function success(email, req){
    var content =
        '$(".alert-dismissible").remove();' +
        '$(".login-container").prepend('+ "\'" +
        '<div class="alert alert-success alert-dismissible" role="alert">'+
        '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
        '<strong>' + req.__('Your account ') + email + req.__(' is verified! ') + '</strong>' + req__('You can now Login') +
        '</div>' +
        "\'" + ');';
    return '<script>' + content + '</script>';
}

function failure(error, req){
    console.log("failure called error:");
    console.log(error);
    var content =
        '$(".alert-dismissible").remove();' +
        '$(".reset-password-container").prepend('+ "\'" +
        '<br>' +
        '<div class="alert alert-danger alert-dismissible" role="alert">'+
        '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
        '<strong>' + req.__('Error: ') + '</strong>' + req.__(error) +
        '</div>' +
        "\'" + ');';
    return '<script>' + content + '</script>';
}

module.exports = router;