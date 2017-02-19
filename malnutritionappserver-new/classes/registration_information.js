function RegistrationInformation(email_address){
    //TODO: find way to get a unique id that we can then assign the registration_information, probably have to get it by querying the Database
    this.email_address = email_address
    
    this.verification_code = undefined;
    this.reset_password_verification_code = undefined;
    
    this.creation_time = new Date().getTime();
    
    this.registered = false;
    
    this.password_reset = false;
    
    this.registration_attempts = 0;
    
    this.reset_password_attempts = 0;
}

RegistrationInformation.prototype = {
    //TODO: add getters for registration_informationname and email, note: password should never be gotten only used internally in a registration_information object
    constructor: RegistrationInformation,
    //initRegistrationInformationFromDatabase initializes a registration_information object based on an object returned from database
    update: function(registration_information){
        
    },

}

function toMongoIdObject(id){
    return new require('mongodb').ObjectID(id.toString());
}

module.exports = RegistrationInformation;