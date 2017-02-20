let models = require("./models.js");

let User = models.User;

function verifyAuthToken(req, res,  next) {
    let authToken = req.get("Authorization");
    if (authToken) {
        User.find_one({auth_token: authToken}, function(err, user) {
            if (err) {
                res.status(403).end({error: "token doesn't match anything"});
            } else {
                req.user = user;
                next();
            }
        });
    } else {
        res.status(403).end({error: "need Authorization header"});
    }
}

module.exports = {
    verifyAuthToken: verifyAuthToken
};
