function Registration(email){
    //TODO: find way to get a unique id that we can then assign the registration_information, probably have to get it by querying the Database
    this.email = email
    
    this.verification_code = undefined;
    this.reset_password_verification_code = undefined;
    
    this.creation_time = new Date().getTime();
    
    this.registered = false;
    
    this.password_reset = false;
    
    this.registration_attempts = 0;
    
    this.reset_password_attempts = 0;
}

Registration.prototype = {
    constructor: Registration,
}

module.exports = Registration;