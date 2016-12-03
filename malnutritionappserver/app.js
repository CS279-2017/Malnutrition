var app = require('express')();
var bodyParser = require('body-parser');


var jsonlint = require("jsonlint");

var fs = require('fs');
var path = require('path');

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

app.post('/', function(req, res) {
    var username = req.body.username,
        password = req.body.password;

    var filePath = path.join(__dirname, 'string.json');

    fs.readFile(filePath, {encoding: 'utf-8'}, function(err,data){
        if (!err){
            // console.log('received data: ' + data);
            res.send(data);
        }else{
            console.log(err);
        }

    });
});

app.post('/validate', function(req, res){
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

