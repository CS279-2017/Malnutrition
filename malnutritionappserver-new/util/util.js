var nodemailer = require('nodemailer');
var ses = require('nodemailer-ses-transport');
var transporter = nodemailer.createTransport(ses({
    accessKeyId: 'AKIAI4Q5NCWOINIUHKQQ',
    secretAccessKey: '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',
    region: 'us-west-2'
}));

var config = require('../config/config')
var serverDomain = config.domain;

const crypto = require('crypto');
const secret = 'SeaTurtleVPNisawesome';

function generateKey(length){
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    for( var i=0; i < length; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    return text;
}

function validateVanderbiltEmail(email_address){
    var nameString = email_address.substring(0, email_address.indexOf("@"));
    var nameStringSplit = nameString.split(".");
    return nameStringSplit.length >= 2 && nameStringSplit.length <= 4 && /@vanderbilt.edu\s*$/.test(email_address);
}

function toMongoIdObject(id){
    if(id){
        return new require('mongodb').ObjectId(id.toString());
    }
}

function hashPassword(password){
    return crypto.createHmac('sha256', secret)
        .update(password)
        .digest('hex');
}

function validateEmail(email){
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    var success = re.test(email);
    var errorMessage = success ? undefined : "Invalid email";
    return {success: success, errorMessage: errorMessage};
}

function validatePassword(password){
    var re = /.{6,}/;
    var success = re.test(password);
    var errorMessage = success ? undefined :
        "Invalid Password, A valid password must: \n" +
        "1. Be at least 6 characters in length";
    return {success: success, errorMessage: errorMessage};
}

//options: container, insertionMethod, link ({label: , href:})
function makeBootstrapAlert(message, options){
    if(options){
        var type = options.type, container = options.container, insertionMethod = options.insertionMethod, link = options.link, header = options.header
    }
    var content =
        '$(".alert-dismissible").remove();' +
        '$("' + (container || ".container") + '").' + (insertionMethod || 'prepend') + '('+ "\'" +
        (header ? header : "") +
        '<div class="alert ' +
            (type == "danger"? "alert-danger" : type == "success" ? "alert-success" : type == "info" ? "alert-info" : type == "warning" ? "alert-warning" : "alert-info") +
        ' alert-dismissible" role="alert">'+
        '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
         message + (link ? ('<a href=' + link.href + ' class="alert-link">' + link.label + '</a>') : "") +
        '</div>' +
        "\'" + ');';
    return '<script>' + content + '</script>';
}

function sendEmail(email, options, callback, errorHandler){
    if(!validateEmail(email)){
        errorHandler("Invalid Email");
        return;
    }
    var body = (options.body == undefined ? "" : options.body + "\n\n") +
         serverDomain  + (options.url ? options.url : '/') + '?'+'email='+email
    if(options.verificationCode){
        var verificationCode = options.verificationCode;
        body += (verificationCode ? '&code='+verificationCode : '');
    }
    if(options.referralCode){
        var referralCode = options.referralCode;
        if(referralCode && referralCode != "null"){
            body += '&referralCode='+referralCode;
        }
    }
    var subject =  options.subject != undefined ? options.subject : 'An Email From SeaTurtleVPN'
    var mailOptions = {
        from: '"SeaTurtleVPN" <noreply@bowenvpn.com>', // sender address
        to: email, // list of receivers
        subject: subject != undefined ? subject : 'An Email From SeaTurtleVPN', // Subject line
        text: (body == undefined ? "" : body + "\n\n")
    }
    // send mail with defined transport object
    transporter.sendMail(mailOptions, function(error, info){
        if(error){
            console.log(error);
            errorHandler("Unable to send email");
            return;
        }
        // console.log("send mail success");
        // console.log('Message sent: ' + info.response);
        callback();
        //send verificationCode to callback as well as email (for testing purposes)
    });
}



module.exports = {
    generateKey: generateKey,
    validateVanderbiltEmail: validateVanderbiltEmail,
    toMongoIdObject: toMongoIdObject,
    hashPassword: hashPassword,
    validateEmail: validateEmail,
    validatePassword: validatePassword,
    makeBootstrapAlert: makeBootstrapAlert,
    sendEmail: sendEmail,
}