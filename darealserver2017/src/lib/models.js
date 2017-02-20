let mongoose = require("mongoose");

let Schema = mongoose.Schema;

let UserSchema = new Schema({
    username: { type: String },
    email: { type: String },
    password_hash: { type: String },
    password_salt: { type: String },
    auth_token: { type: String }
});

let PendingRegistrationSchema = new Schema({
    username: { type: String },
    email: { type: String },
    password_hash: { type: String },
    password_salt: { type: String },
    verification_code: { type: String }
});

let User = mongoose.model("User", UserSchema);
let PendingRegistration = mongoose.model("PendingRegistration", PendingRegistrationSchema);
module.exports =  {
    User: User,
    PendingRegistration: PendingRegistration
};
