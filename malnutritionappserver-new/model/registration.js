function Registration(email){
    //TODO: find way to get a unique id that we can then assign the registration_information, probably have to get it by querying the Database
    this.email = email //String
    
    this.verification_code = undefined; //String
    this.reset_password_verification_code = undefined; //String
    
    this.creation_time = new Date().getTime(); //milliseconds since 1970
    
    this.registered = false; //boolean
    
    this.password_reset = false; //boolean
    
    this.registration_attempts = 0; //int
    
    this.reset_password_attempts = 0;//int
}

Registration.prototype = {
    constructor: Registration,
}

module.exports = Registration;