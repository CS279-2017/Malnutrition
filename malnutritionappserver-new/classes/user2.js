function User(email_address, password){
    //TODO: find way to get a unique id that we can then assign the user, probably have to get it by querying the Database
    // this._id = undefined;

    if(email_address != undefined){
        var name = parseNameFromEmailVanderbilt(email_address);
        this.firstName = name.firstName;
        this.lastName = name.lastName;
    }

    if(password != undefined){
        this.password = password;
    }
    this.email = email_address

    this.verified = false;
    this.creation_time = new Date().getTime();

    // this.device_token = undefined;
    // this.venmo_id = undefined ;
    // this.socket_id = undefined;

    // this.profile_picture = undefined;


    // this.buying_listing_ids = [];
    // this.selling_listing_ids = [];

    // this.location = undefined;
    // this.logged_in = true;
}

// User.prototype = {
//     //TODO: add getters for username and email, note: password should never be gotten only used internally in a user object
//     constructor: User,
// }

function toMongoIdObject(id){
    return new require('mongodb').ObjectID(id.toString());
}

function parseNameFromEmailVanderbilt(email_address){
    String.prototype.capitalizeFirstLetter = function() {
        return this.charAt(0).toUpperCase() + this.slice(1);
    }
    email_address = email_address.toLowerCase(); //converts email_address to lower_case because email_addresses are case insensitive
    var first_name;
    var last_name;
    var nameString = email_address.substring(0, email_address.indexOf("@"));
    var nameStringSplit = nameString.split(".");
    if(nameStringSplit.length == 2){
        first_name = nameStringSplit[0];
        last_name = nameStringSplit[1];
    }
    else if(nameStringSplit.length ==3){
        first_name = nameStringSplit[0];
        last_name = nameStringSplit[2];
    }
    else if(nameStringSplit.length == 4){
        first_name = nameStringSplit[0];
        last_name = nameStringSplit[2];
    }
    else{
        error_handler("the vanderbilt email is of invalid format");
        return;
    }
    first_name = first_name.toLowerCase(); //converts first name to lower case
    first_name = first_name.capitalizeFirstLetter(); //then capitalizes first letter
    last_name = last_name.toLowerCase(); //converts last name to lower case
    last_name = last_name.capitalizeFirstLetter(); //then capitalizes first letter
    return {first_name: first_name, last_name: last_name};
}

module.exports = User;