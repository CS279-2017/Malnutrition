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
    
    this.vumcUnit = undefined
    this.clinicianType = undefined
    this.yearsInPractice = undefined;
    this.preferredFirstName = undefined
    this.preferredLastName = undefined;
}

User.prototype = {
    constructor: User,
}

function parseNameFromEmailVanderbilt(email){
    String.prototype.capitalizeFirstLetter = function() {
        return this.charAt(0).toUpperCase() + this.slice(1);
    }
    email = email.toLowerCase(); //converts email to lower_case because emailes are case insensitive
    var firstName;
    var lastName;
    var nameString = email.substring(0, email.indexOf("@"));
    var nameStringSplit = nameString.split(".");
    if(nameStringSplit.length == 2){
        firstName = nameStringSplit[0];
        lastName = nameStringSplit[1];
    }
    else if(nameStringSplit.length ==3){
        firstName = nameStringSplit[0];
        lastName = nameStringSplit[2];
    }
    else if(nameStringSplit.length == 4){
        firstName = nameStringSplit[0];
        lastName = nameStringSplit[2];
    }
    else{
        error_handler("the vanderbilt email is of invalid format");
        return;
    }
    firstName = firstName.toLowerCase(); //converts first name to lower case
    firstName = firstName.capitalizeFirstLetter(); //then capitalizes first letter
    lastName = lastName.toLowerCase(); //converts last name to lower case
    lastName = lastName.capitalizeFirstLetter(); //then capitalizes first letter
    return {firstName: firstName, lastName: lastName};
}

module.exports = User;