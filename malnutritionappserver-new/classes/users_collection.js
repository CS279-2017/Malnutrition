var User = require("./user2.js");
const crypto = require('crypto');
const secret = 'vandylistisawesome';
var hat = require('hat');

function UsersCollection(database){
    this.database = database;
    this.collection_users = database.collection('users');
}

UsersCollection.prototype = {
    constructor: UsersCollection,
    add: function(user, callback, error_handler){
        var collection_users = this.collection_users;
        user.password = hashPassword(user.password);
        if(user.email != undefined){
            this.collection_users.update({email: user.email}, {$set: user}, {upsert: true}, function (err, count, status) {
                if(err){error_handler(err.message);}
                else{
                    if(callback != undefined && callback != null){callback(user);}
                }
            });
        }
        else {
            user.password = hashPassword(user.password);
            this.collection_users.insert(user, function (err, count, status) {
                if (err) {
                    error_handler(err.message);
                }
                else {
                    collection_users.find(user).toArray(function (err, docs) {
                        if (docs.length == 1) {
                            var user = docs[0];
                            if (callback != undefined) {
                                callback(user);
                            }
                        }
                        else {
                            error_handler("more than 1 listing inserted into database");
                            return;
                        }
                    });
                }
            });
        }
    },
    update: function(email, updated_params, callback, error_handler){
        this.collection_users.update({email: email}, {$set: updated_params}, function (err, count, status) {
            if(err){error_handler(err.message);}
            else{
                if(callback != undefined && callback != null){callback();}
            }
        });
    },
    getEmail: function(email, callback, error_handler){
        this.collection_users.find({email: email}).toArray(function(err, docs) {
            if(docs.length >= 1){
                var user = docs[0];
                callback(user);
            }
            else{
                error_handler("No user found");
            }
        });
    },
    get: function(user_ids_input, callback, error_handler){
        var user_ids = user_ids_input;
        if(!(Array.isArray(user_ids))){
            // error_handler("user_ids must be an array!")
            user_ids = [user_ids];
        }
        var user_id_arr = [];
        for(var i=0; i< user_ids.length; i++){
            user_id_arr.push(toMongoIdObject(user_ids[i]));
        }

        this.collection_users.find({_id: {$in:user_id_arr}}).toArray(function(err, docs) {
            if(docs.length > 0){
                var users_arr = [];
                for(var j=0; j< docs.length; j++){
                    var user = docs[j];
                    users_arr.push(user);
                }
                if(users_arr.length == 1 && !(Array.isArray(user_ids_input))){
                    callback(users_arr[0]);
                }
                else{
                    callback(users_arr);
                }
            }
            else{
                if(user_ids.length > 1){
                    error_handler("No users were found");
                }
                else{
                    error_handler("User wasn't found");
                }

            }
        });
    },
    getForEmailAddress: function(email, callback, error_handler){
        this.collection_users.find({email: email}).toArray(function(err, docs) {
            if(docs.length > 0) {
                var user = docs[0];
                callback(user);
            }
            else{
                error_handler("User with email " + email + " was not found");
            }
        });
    },
    remove: function(_id, callback){
        
    },
    size: function(){

    },

    getAll: function(callback){
        this.collection_users.find({loggedIn: true}).toArray(function(err, docs) {
            if(docs.length > 0) {
                var active_users = [];
                for(var i=0; i<docs.length; i++){
                    var user = docs[j];
                    active_users.push(user);
                }
                callback(active_users);
            }
            else{
                callback([])
            }
        });
    },
    //TODO: find some faster way to search users on socket id, maybe make another hashmap
    getUserBySocketId: function(socket_id, callback){
        this.collection_users.find({socket_id: socket_id}).toArray(function(err, docs) {
            if(docs.length > 0) {
                var user = docs[0];
                callback(user);
            }
            else{
                callback([])
            }
        });
    },
    authenticate: function(auth_key, userId, callback, error_handler){
        this.collection_users.find({_id: toMongoIdObject(userId), authKey: auth_key, loggedIn: true}).toArray(function(err, docs) {
            if (!err) {
                if (docs.length > 0) {
                    var user = docs[0];
                    if(user.authKeyExpirationTime < new Date().getTime()){
                        error_handler("Your session has expired");
                        return;
                    }
                    callback(user);
                }
                else {
                    error_handler("Invalid Authentication Information");
                    return;
                }
            }
            else {
                error_handler("An error occured while authenticating");
                return;
            }
        });
    },
    login: function(email, password, callback, error_handler){
        password = hashPassword(password);
        var collection_users = this.collection_users;
        this.collection_users.find({email: email, password: password}).toArray(function (err, docs) {
            if (docs.length == 1) {
                var user = docs[0];
                if(!user.verified){
                    error_handler("You haven't verified your account! Please check your email and click the verification link");
                }
                else{
                    collection_users.findAndModify(
                        {email: email, password: password},
                        [],
                        {$set:
                        {lastLoginTime: new Date().getTime(), loggedIn: true, authKey: generateKey(), authKeyExpirationTime: new Date().getTime() + (24*1000*60*60)}
                        },
                        {new: true},
                        function (err, docs) {
                            if(!err){
                                console.log(docs);
                                if(docs.lastErrorObject.updatedExisting == true) {
                                    var value = docs.value;
                                    if(callback != undefined){ callback({authKey: value.authKey, userId: value._id}); }
                                }
                                else{
                                    console.log(err);
                                    error_handler("Invalid Login Information");
                                }
                            }
                            else{
                                error_handler("An Error Occured while Logging in!")
                            }
                        }
                    );
                }
            }
            else {
                error_handler("Invalid login information");
                return;
            }
        });
    },
    logout: function(user_id, callback, error_handler){
        this.collection_users.update({_id: toMongoIdObject(user_id)}, {$set: {loggedIn: false}}, function (err, count, status) {
            if(!err){
                callback();
            }
            else{
                error_handler("logout failed");
            }
        });
    },
    //adds listing_id to buying_listing_ids of user, if called multiple times for same user_id and listing_id, will only add listing_id once.
    addBuyingListingId: function(user_id, listing_id, callback, error_handler){
        this.collection_users.update({_id: toMongoIdObject(user_id)}, {$addToSet: {buying_listing_ids: listing_id}}, function (err, count, status) {
            if(!err){
                callback();
            }
            else{
                console.log("err:" + err)
                console.log("count: " + count);
                error_handler("addBuyingListingId failed");
            }
        });
    },
    removeBuyingListingId: function(user_id, listing_id, callback, error_handler){
        this.collection_users.update({_id: toMongoIdObject(user_id)}, {pull: {buying_listing_ids: listing_id}}, function (err, count, status) {
            if(!err){
                callback();
            }
            else{
                error_handler("removeBuyingListingId failed");
            }
        });
    },
    addSellingListingId: function(user_id, listing_id, callback, error_handler){
        this.collection_users.update({_id: toMongoIdObject(user_id)}, {$addToSet: {selling_listing_ids: listing_id}}, function (err, count, status) {
            if(!err){
                callback();
            }
            else{
                error_handler("addSellingListingId failed");
            }
        });
    },
    removeSellingListingId: function(user_id, listing_id, callback, error_handler){
        this.collection_users.update({_id: toMongoIdObject(user_id)}, {pull: {selling_listing_ids: listing_id}}, function (err, count, status) {
            if(!err){
                callback();
            }
            else{
                error_handler("removeSellingListingId failed");
            }
        });
    },
    updateVenmoId: function(user_id, venmo_id, callback, error_handler) {
        this.collection_users.update({_id: toMongoIdObject(user_id)}, {$set: {venmo_id: venmo_id}}, function (err, count, status) {
            if (!err) {
                callback();
            }
            else {
                error_handler("updateVenmoId failed");
            }
        });
    },
    updateProfilePicture: function(user_id, profile_picture, callback, error_handler){
        this.collection_users.update({_id: toMongoIdObject(user_id)}, {$set: {profile_picture: profile_picture}}, function (err, count, status) {
            if (!err) {
                // console.log(count);
                callback();
            }
            else {
                error_handler("updateVenmoId failed");
            }
        });
    },

}

function generateKey(length){
    return hat();
    // return Math.random().toString(36).substring(length);
}

function toMongoIdObject(id){
    if(id != undefined){
        return new require('mongodb').ObjectId(id.toString());
    }
}

function hashPassword(password){
    return crypto.createHmac('sha256', secret)
        .update(password)
        .digest('hex');
}

module.exports = UsersCollection;
