function User(email, password){
    if(email != undefined){
        var name = parseNameFromEmailVanderbilt(email);
        this.firstName = name.firstName; //string
        this.lastName = name.lastName; //string
    }

    this.password = password; //string
    this.email = email //string

    this.verified = false; //boolean
    this.creationTime = new Date().getTime(); //milliseconds since 1970
}

User.prototype = {
    constructor: User,
}

function parseNameFromEmailVanderbilt(email){
    String.prototype.capitalizeFirstLetter = function() {
        return this.charAt(0).toUpperCase() + this.slice(1);
    }
    email = email.toLowerCase(); //converts email to lower_case because emailes are case insensitive
    var first_name;
    var last_name;
    var nameString = email.substring(0, email.indexOf("@"));
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