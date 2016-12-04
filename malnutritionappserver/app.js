var app = require('express')();
var bodyParser = require('body-parser');


var jsonlint = require("jsonlint");

var fs = require('fs');
var path = require('path');

app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

app.set('port', (process.env.PORT || 3000));

var auth_key_arr = [];

var server_password = "12345";

app.listen(app.get('port'), function(){
    //Callback triggered when server is successfully listening. Hurray!
    console.log("Server listening on: http://localhost:%s", app.get('port'));
});

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

app.post('/get_json', function(req, res){
    var filePath = path.join(__dirname, 'string.json');
    fs.readFile(filePath, {encoding: 'utf-8'}, function (err, data) {
        if (!err) {
            console.log("json sent to client!");
            res.send({data: {json: data}, error: null});
        } else {
            console.log(err);
            res.send({data: null, error: err});
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

app.post('/authenticate', function(req, res) {
    console.log("login called!")
    // var username = req.body.username,
    var key = req.body.auth_key;
    if(auth_key_arr.indexOf(key) != -1) {
        console.log("authentication successful!")
        res.send({data: null, error: null});
    }
    else{
        console.log("invalid auth key!")
        res.send({data: null, error: "invalid auth key"});
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
    var auth_key = req.body.auth_key;
    var filePath = path.join(__dirname, 'string.json');
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

function generateKey(length){
    return Math.random().toString(36).substring(length);
}


// fs.readFile(filePath, 'utf8', function (err, data) {
//     if (err) throw err;
//     //Do your processing, MD5, send a satellite to the moon, etc.
//
// });
//
// fs.writeFile (savPath, data, function(err) {
//     if (err) throw err;
//     console.log('complete');
// });

// app.post('/', function(req, res){
//
// })

