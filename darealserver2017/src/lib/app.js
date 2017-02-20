let express = require("express");
let mongoose = require("mongoose");
let bodyParser = require("body-parser");
let morgan = require("morgan");

let auth = require("./auth");

// TODO plz change plz
const APP_SECRET = "please change this plz";
mongoose.connect("mongodb://localhost:27017/malnutrition");
const SENDGRID_USERNAME = process.env.SENDGRID_USERNAME;
const SENDGRID_PASSWORD = process.env.SENDGRID_PASSWORD;

let app = express();
app.use(bodyParser.json({}));
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(morgan("combined"));

console.log(auth);
app.use("/auth", auth.createRouter(APP_SECRET, SENDGRID_USERNAME, SENDGRID_PASSWORD));

app.listen(3000, function() {
    console.log("app listening");
});
