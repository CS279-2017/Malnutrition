let express = require("express");
let bcrypt = require("bcrypt");
let nodemailer = require("nodemailer");

let models = require("./models");

let User = models.User;
let PendingRegistration = models.PendingRegistration;

function generateRandomAlphaNumeric(length) {
    let charset = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    let s = "";
    for (let i = 0; i < length; i++) {
        let j = Math.floor(Math.random() * charset.length);
        s += charset[j];
    }
    return s;
}

function sendVerificationEmail(verificationCode, email, mailTransporter, cb) {
    let subject = "Verification Code for NutriRisk";
    let text1 = "Click on the link below to verify your email, if you did not registed an account disregard this email";
    let text2 = "https://nutriscreen.herokuapp.com/verify_registration_email?verification_code=" + verificationCode + "&email=" + email;
    let mailOptions = {
        from: "'NutriRisk' <bowen.jin@vanderbilt.edu>",
        to: email,
        subject: subject,
        text: text1 + "\n" + text2
    };
    mailTransporter.sendMail(mailOptions, cb);
}

function createRouter(appSecret, sendGridUsername, sendGridPassword) {
    let mailTransporter = nodemailer.createTransport({
        service: "SendGrid",
        auth: {
            user: sendGridUsername,
            pass: sendGridPassword
        }
    });
    let router = express.Router();
    router.post("/signup", function(req, res, next) {
        let data = req.body;
        if (data
            && data.username
            && data.password
            && data.email) {
            User.findOne({ username: data.username }, function(err, user) {
                if (user) {
                    res.status(400).send({error: "username already in use"});
                } else {
                    bcrypt.hash(data.password, 1, function(err, hash) {
                        if (err) {
                            next(err);
                        } else {
                            let verificationCode = generateRandomAlphaNumeric(6);
                            let newPendingRegistration = {
                                username: data.username,
                                email: data.email,
                                password_hash: hash,
                                password_salt: "",
                                verification_code: verificationCode
                            };
                            let pendingRegistrationModel =
                                    new PendingRegistration(newPendingRegistration);
                            pendingRegistrationModel.save(function(err) {
                                if (err) {
                                    res.status(400).send(err);
                                } else {
                                    sendVerificationEmail(
                                        verificationCode,
                                        data.email,
                                        mailTransporter,
                                        function(err) {
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
                }
            });
        } else {
            res.status(400).send({error: "not all fields present"});
        }
    });

    // this shouldn't really be a GET as in it has side effects but it's
    // easier for the user i guess
    router.get("/verify_email", function(req, res) {
        console.log("hi");
        let data = req.query;
        if (data && data.verification_code && data.email) {
            let verificationCode = data.verification_code;
            let email= data.email;
            PendingRegistration.findOne(
                { verification_code: verificationCode,
                  email: email },
                "username email password_hash password_salt",
                function(err, pendingRegistration) {
                    if (err) {
                        res.status(403).send({error: "email or verification_code wrong"});
                    } else {
                        let newUser = {
                            username: pendingRegistration.username,
                            email: pendingRegistration.email,
                            password_hash: pendingRegistration.password_hash,
                            password_salt: pendingRegistration.password_salt,
                            auth_token: generateRandomAlphaNumeric(32)
                        };
                        let userModel = new User(newUser);
                        userModel.save(function(err) {
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
                }
            );
        } else {
            console.log(req.query);
            res.status(400).send({error: "not all fields present"});
        }
    });

    router.get("/token", function(req, res) {
        let data = req.query;
        if (data && data.username && data.password) {
            // TODO make this a real login by hitting DB
            User.findOne(
                { username: data.username },
                "password_hash password_salt auth_token",
                function(err, user) {
                    if (user) {
                        bcrypt.compare(data.password, user.password_hash, function(err, matching_pass) {
                            if (matching_pass) {
                                console.log(user);
                                res.status(200).send({authToken: user.auth_token});
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

    return router;
}

module.exports = {
    createRouter: createRouter
};
