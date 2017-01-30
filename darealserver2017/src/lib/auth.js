let express = require("express");
let jwt = require("jsonwebtoken");
let bcrypt = require("bcrypt");

let models = require("./models");
let router = express.Router();

// TODO plz change plz
const APP_SECRET = "please change this plz";
const ACCESS_TOKEN_OPTS = {
    expiresIn: 60 * 60  // 1 hour
};

let User = models.User;

router.post("/signup", function(req, res, next) {
  let data = req.body;
  if (data
      && data.username
      && data.password
      && data.email) {
    User.findOne({ username: data.username }, function(err, user) {
      if (user) {
        console.log(user);
        res.status(400).end({error: 'username already in use'});
      } else {
        bcrypt.hash(data.password, 1, function(err, hash) {
          if (err) {
            next(err);
          } else {
            let newUser = {
              username: data.username,
              email: data.email,
              password_hash: hash,
              password_salt: ""
            };
            let userModel = new User(newUser);
            userModel.save(function(err, userModel) {
              if (err) {
                res.status(400).send(err);
              } else {
                res.status(201).send({
                  username: data.username,
                  email:    data.email
                });
              }
            });
          }
        });
      }
    });
  } else {
    res.status(400).send({error: "not all fields present"});
  }
});

router.get("/refreshtoken", function(req, res, next) {
  let data = req.query;
  if (data && data.username && data.password) {
    // TODO make this a real login by hitting DB
    User.findOne(
      { username: data.username },
      'password_hash password_salt',
      function(err, user) {
        if (user) {
          bcrypt.compare(data.password, user.password_hash, function(err, matching_pass) {
            if (matching_pass) {
              let payload = {
                username: data.username
              };
              jwt.sign(payload, APP_SECRET, {}, function(err, token) {
                if (err) {
                  next(err);
                } else {
                  res.end(token);
                }
              });
            } else {
              res.status(401).send({error: "incorrect password"});
            }
          });
        } else {
          res.status(401).send({error: "user doesn't exist"});
        }
    });
  } else {
    res.sendStatus(400);
  }
});

router.get("/accesstoken", function(req, res, next) {
  if (typeof(req.query.refreshtoken) === "string") {
    let refreshToken = req.query.refreshtoken;
    console.log(refreshToken);
    jwt.verify(refreshToken, APP_SECRET, function(err, decoded) {
      if (err) {
        res.sendStatus(401);
      } else {
        let refreshTokenPayload = decoded;
        let accessTokenPayload= {
          username: refreshTokenPayload.username
        };
        jwt.sign(accessTokenPayload, APP_SECRET, ACCESS_TOKEN_OPTS, function(err, token) {
          if (err) {
            next(err);
          }
          res.end(token);
        });
      }
    });
  } else {
    res.sendStatus(400);
  }
});

module.exports = {
  router: router
};
