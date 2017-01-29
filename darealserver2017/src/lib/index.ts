import * as express from "express";
import * as jwt from "jsonwebtoken";

// TODO plz change plz
const APP_SECRET = "please change this plz";
const ACCESS_TOKEN_OPTS = {
    expiresIn: 60 * 60  // 1 hour
};

let app = express();

interface LoginInfo {
    username: string,
    password: string
}

interface RefreshTokenPayload {
    username: string
}

interface AccessTokenPayload {
    username: string
}

app.get("/auth/refreshtoken", function(req: express.Request, res: express.Response, next: express.NextFunction) {
    if (req.query && typeof(req.query.username) === "string" && typeof(req.query.password) === "string") {
        let loginInfo: LoginInfo = req.query;
        // TODO make this a real login by hitting DB
        if (loginInfo.username === "username" && loginInfo.password === "password") {
            let payload: RefreshTokenPayload = {
                username: loginInfo.username
            };
            jwt.sign(payload, APP_SECRET, {}, function(err: Error, token: string) {
                if (err) {
                    return next(err);
                }
                res.end(token);
            });
        } else {
            res.sendStatus(401);
        }
    } else {
        res.sendStatus(400);
    }
});

app.get("/auth/accesstoken", function(req: express.Request, res: express.Response, next: express.NextFunction) {
    if (typeof(req.query.refreshtoken) === "string") {
        let refreshToken: string = req.query.refreshtoken;
        console.log(refreshToken);
        jwt.verify(refreshToken, APP_SECRET, function(err: Error, decoded: any) {
            if (err) {
                res.sendStatus(401);
            } else {
                let refreshTokenPayload: RefreshTokenPayload = decoded;
                let accessTokenPayload: AccessTokenPayload = {
                    username: refreshTokenPayload.username
                }
                jwt.sign(accessTokenPayload, APP_SECRET, ACCESS_TOKEN_OPTS, function(err: Error, token: string) {
                    if (err) {
                        return next(err);
                    }
                    res.end(token);
                });
            }
        });
    } else {
        res.sendStatus(400);
    }
});

app.listen(3000, function() {
    console.log("app listening");
});