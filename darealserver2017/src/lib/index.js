let express = require("express");
let mongoose = require("mongoose");
let auth = require("./auth");
let bodyParser = require("body-parser");

mongoose.connect("mongodb://localhost:33701/malnutrition");

let app = express();
app.use(bodyParser.json({}));
app.use(bodyParser.urlencoded({extended:true}));

app.use("/auth", auth.router);

app.listen(3000, function() {
  console.log("app listening");
});
