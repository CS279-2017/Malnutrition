let express = require("express");
let mongoose = require("mongoose");
let auth = require("./auth");
let bodyParser = require("body-parser");


// TODO plz change plz
const APP_SECRET = "please change this plz";
const ACCESS_TOKEN_OPTS = {
  expiresIn: 60 * 60  // 1 hour
};
mongoose.connect("mongodb://localhost:33701/malnutrition");

let app = express();
app.use(bodyParser.json({}));
app.use(bodyParser.urlencoded({extended:true}));

console.log(auth);
app.use("/auth", auth.createRouter(APP_SECRET, ACCESS_TOKEN_OPTS));

app.listen(3000, function() {
  console.log("app listening");
});
