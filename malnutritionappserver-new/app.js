var User = require("./model/user.js");

var db = require("./db/db");
var jsonlint = require("jsonlint");
var fs = require('fs');
var path = require('path');
var bodyParser = require('body-parser');

var app = require('express')();
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());
app.set('port', (process.env.PORT || 3000));
app.listen(app.get('port'), function(){
    //Callback triggered when server is successfully listening. Hurray!
    console.log("Server listening on: http://localhost:%s", app.get('port'));
});

///get_json gets the JSON for the mobile app to load review of symptoms as well as assessments data.
app.post('/get_json',function(req, res){
    console.log("/get_json called!");
    console.log(req.body);
    var type = req.body.type;
    console.log(type);
    if(type == "symptoms") {
        var filePath = path.join(__dirname, 'symptoms.json');
        read(filePath);
    }
    else if(type == "assessment"){
        var filePath = path.join(__dirname, 'assessment.json');
        read(filePath);
    }
    else{
        console.log("invalid type");
    }

    function read(filePath){
        console.log("filePath: " + filePath);
        fs.readFile(filePath, {encoding: 'utf-8'}, function (err, data) {
            if (!err) {
                console.log("json sent to client!");
                res.send({data: {json: data}, error: null});
            } else {
                console.log(err);
                res.send({data: null, error: err});
            }
        });
    }

})

/*
BELOW ARE THE
LOGIN/AUTHENTICATION/REGISTRATION/PASSWORD RESET FOR MOBILE APP

 */
var userRoutes = require('./routes/user');
app.use('/user', userRoutes);

/**
 * ALL THE CODE BELOW THIS POINT IS FOR THE WEBSITE FRONTEND, I.E IT WILL BE REPLACED SOON
 *
 *
 */

var auth_key_arr = [];
var server_password = "12345";

app.get('/', function (req, res) {
    var filePath = path.join(__dirname, 'main.html');
    fs.readFile(filePath, {encoding: 'utf-8'}, function(err,data){
        if (!err){
            res.send(data);
        }else{
            console.log(err);
        }
    });
})

app.post('/login', function(req, res) {
    console.log("login called!")
    // var username = req.body.username
    var password = req.body.password;

    if(password == server_password) {
        console.log("passwords match!")
        var auth_key = generateKey(24);
        auth_key_arr.push(auth_key);
        //set a timer to remove the key after a certain amount of time
        setTimeout(function(){
            var index = auth_key_arr.indexOf(auth_key);
            if (index > -1) {
                auth_key_arr.splice(index, 1);
            }
        }, 1800000)
        res.send({data: {auth_key: auth_key}, error: null});
    }
    else{
        console.log("passwords don't match!")
        res.send({data: null, error: "invalid password"});
    }
});


app.post('/validate', function(req, res){
    console.log("validate called!")
    var auth_key = req.body.auth_key
    var json = req.body.json;
    if(auth_key_arr.indexOf(auth_key) != -1) {
        console.log("authentication successful!")
        try {
            var result = jsonlint.parse(json);
            res.send({data: null, error: null});
        } catch(e) {
            console.log("Error caught!");
            res.send({data: null, error: e.message});
        }
    }
    else{
        console.log("invalid auth key!")
        res.send({data: null, error: "invalid auth key"});
    }
});

app.post('/submit', function(req, res){
    console.log("submit called!")
    var json = req.body.json;
    var type = req.body.type;
    var auth_key = req.body.auth_key;
    var filePath;
    if(type == "symptoms") {
        filePath = path.join(__dirname, 'symptoms.json');
    }
    else if(type == "assessment"){
        filePath = path.join(__dirname, 'assessment.json');
    }
    if(auth_key_arr.indexOf(auth_key) != -1) {
        try {
            var result = jsonlint.parse(json);
            //if parse is unsuccessful then it will throw an error and go to catch block
            fs.writeFile (filePath, json, function(err) {
                if (err) throw err;
                console.log('successfully wrote to file complete');
                res.send({data: null, error: null});
            });
        } catch(e) {
            console.log("Error caught!");
            res.send({data: null, error: e.message});
        }
    }
    else{
        console.log("invalid auth key!")
        res.send({data: null, error: "invalid auth key"});
    }
});

