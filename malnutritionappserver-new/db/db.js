var UserCollection = require("./usersCollection.js");
var RegistrationInformationCollection = require("./registrationInformationCollection.js")

var MongoClient = require('mongodb').MongoClient;

var config = require('../config/config')

var url = process.env.MONGODB_URL

var registrationInformationCollection;
var userCollection;

MongoClient.connect(url, function (err, db) {
    if (err) {
        console.log('Unable to connect to the server. Error:' + err);
        errorHandler('Database initialization failed');
        return;
    }
    registrationInformationCollection = new RegistrationInformationCollection(db);
    userCollection = new UserCollection(db);

    module.exports.users = userCollection;
    module.exports.registration = registrationInformationCollection;
});