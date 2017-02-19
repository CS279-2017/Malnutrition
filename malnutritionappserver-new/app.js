var User = require("./classes/user2.js");
var UserCollection = require("./classes/users_collection.js");
var RegistrationInformation = require("./classes/registration_information.js")
var RegistrationInformationCollection = require("./classes/registration_information_collection.js")


var app = require('express')();

var hat = require('hat');

var jsonlint = require("jsonlint");

var MongoClient = require('mongodb').MongoClient;
// Connection URL. This is where your mongodb server is running.
var url = process.env.MONGODB_URL

var registration_information_db;
var user_db;

MongoClient.connect(url, function (err, db) {
    if (err) {
        console.log('Unable to connect to the server. Error:' + err);
        return;
    }
    registration_information_db = new RegistrationInformationCollection(db);
    user_db = new UserCollection(db);
});


var fs = require('fs');
var path = require('path');

var bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

app.set('port', (process.env.PORT || 3000));


var auth_key_arr = [];

var user_table = {
    "bowen.jin@vanderbilt.edu":"nutririsk"
};

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

app.post('/login_mobile', function(req, res){
    var email = req.body.email;
    var password = req.body.password;
    user_db.login(email, password, function(object){
        var authKey = object.authKey;
        var userId = object.userId;
        res.send({data: {authKey: authKey, userId: userId}, error: null});
    }, function(error){
        res.send({data: null, error: error});
    })
    // if(user_table[email] == password){
    //     var auth_key = generateKey(24);
    //     auth_key_arr.push(auth_key);
    //     //set a timer to remove the key after a certain amount of time
    //     setTimeout(function(){
    //         var index = auth_key_arr.indexOf(auth_key);
    //         if (index > -1) {
    //             auth_key_arr.splice(index, 1);
    //         }
    //     }, 1800000)
    //     res.send({data: {auth_key: auth_key}, error: null});
    // }
})

app.post('/register_mobile', function(req, res){
    console.log("/register_mobile called!");
    var email = req.body.email;
    var password = req.body.password;

    function error_handler(error){
        res.send({data: null, error: error})
    }
    registration_information_db.registerEmail(email, function(){
        console.log("register mobile completed!");
        var user = new User(email, password);
        user_db.add(user, function(){
            res.send({data: null, error: null});
        }, error_handler);
    }, error_handler);
});

app.get('/register_verification_code', function(req, res){
    console.log("register verification code called!");
    var email = req.param("email");
    var verification_code = req.param("code");
    registration_information_db.registerVerificationCode(verification_code, email, function(){
        user_db.update(email, {verified: true}, function(){
            res.send("Your account " + email + " has been verified! You can now login via the NutriRisk app");
        }, function(error){
            res.send("An error occured");
        })
    }, function(error){
        res.send("Invalid verification code");
    })
})

app.post('/reset_password', function(req, res){
    console.log("reset password called!");
    var email = req.param("email");
    var password = req.param("password")
    function error_handler(error){
        res.send({data: null, error: error})
    }
    registration_information_db.resetPasswordEmail(email, function(){
        user_db.update(email, {newPassword: password}, function(){
            res.send({data: null, error: null});
        }, error_handler)
    }, error_handler)
});

app.get('/reset_password_verification', function(req, res){
    console.log("register password email called!");
    var email = req.param("email");
    var verification_code = req.param("verification_code");

    function error_handler(error){
        res.send("An error occured");
    }

    registration_information_db.resetPasswordVerificationCode(verification_code, email, function() {
        user_db.getEmail(email, function (user) {
            user_db.add({email: user.email, password: user.newPassword, newPassword: null}, function () {
                res.send("Your account " + email + " has been verified! You can now login via the NutriRisk app");
            });
        }, error_handler)
    }, error_handler);
})

app.post('/authenticate', function(req, res) {
    console.log("authenticate called!")
    // var username = req.body.username,
    var userId = req.body.userId;
    var authKey = req.body.authKey;
    user_db.authenticate(authKey, userId, function(){
        console.log("authentication successful!")
        res.send({data: null, error: null})
    }, function(error){
        console.log("invalid auth key!")
        res.send({data: null, error: error});
    });
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

// module.exports = {host: server.address().address}

