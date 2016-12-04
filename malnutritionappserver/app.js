var app = require('express')();
var bodyParser = require('body-parser');


var jsonlint = require("jsonlint");

var fs = require('fs');
var path = require('path');

var server_password = "12345";


app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

var port = 3000;
app.listen(port, function(){
    //Callback triggered when server is successfully listening. Hurray!

    console.log("Server listening on: http://localhost:%s", port);
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

app.post('/login', function(req, res) {
    console.log("login called!")
    // var username = req.body.username,
    var server_password = "12345";
    var password = req.body.password;


    var filePath = path.join(__dirname, 'string.json');
    if(password == server_password) {
        console.log("passwords match!")
        fs.readFile(filePath, {encoding: 'utf-8'}, function (err, data) {
            if (!err) {
                console.log('received data: ' + data);
                res.send({data: data, error: null});
            } else {
                console.log(err);
                res.send({data: null, error: err});
            }
        });
    }
    else{
        console.log("passwords dont match!")
        res.send({data: null, error: "invalid password"});
    }
});

app.post('/validate', function(req, res){
    console.log("validate called!")
    var json = req.body.json;
    console.log(json);
    try {
        var result = jsonlint.parse(json);
        console.log(result)
        res.send({data: result, error: null});
    } catch(e) {
        console.log("Error caught!");
        res.send({data: null, error: e.message});
        // console.log(e);
        // console.log(e.message)
    }
});

app.post('/update_json', function(req, res){
    console.log("update json called!")
    var json = req.body.json;
    var password = req.body.password;

    var password = req.body.password;
    var filePath = path.join(__dirname, 'string.json');

    console.log(json);
    try {
        var result = jsonlint.parse(json);

        console.log(result)
        fs.writeFile (filePath, json, function(err) {
            if (err) throw err;
            console.log('successfully wrote to file complete');
            res.send({data: null, error: null});
        });
    } catch(e) {
        console.log("Error caught!");
        res.send({data: null, error: e.message});
        // console.log(e);
        // console.log(e.message)
    }
})

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

