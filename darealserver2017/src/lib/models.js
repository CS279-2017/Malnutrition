let mongoose = require("mongoose");

let Schema = mongoose.Schema;

let UserSchema = new Schema({
  username: { type: String },
  email: { type: String },
  password_hash: { type: String },
  password_salt: { type: String }
});

let User = mongoose.model('User', UserSchema);
module.exports =  { User: User };
