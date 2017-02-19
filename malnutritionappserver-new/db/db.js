var UserCollection = require("./usersCollection.js");
var RegistrationCollection = require("./registrationCollection.js")

var MongoClient = require('mongodb').MongoClient;

var url = process.env.MONGODB_URL || "mongodb://localhost:27017/nutririsk"

var registrationCollection;
var userCollection;

MongoClient.connect(url, function (err, db) {
    if (err) {
        console.log('Unable to connect to the server. Error:' + err);
        return;
    }
    registrationCollection = new RegistrationCollection(db);
    userCollection = new UserCollection(db);

    module.exports.users = userCollection;
    module.exports.registration = registrationCollection;
});