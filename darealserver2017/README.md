dis da backend api

# Usage

## Api

* /auth
  * GET /refreshtoken
    * Query Params:
      * username: \<username\>
      * password: \<password\>
    * Response:
      * 200: \<refresh token\>
  * GET /accesstoken
    * Headers:
      * Authorization: \<Refresh Token\>
    * Response:
      * 200: \<access token\>

## Usage Specifics

### Authentication

Authentication scheme is by refresh token using Json WebTokens (JWT). Upon the user first logging in, the app should request a refresh token using the username and password of a user. The app then keeps the refresh token in internal storage. The refresh token can be used to request new access tokens, which are used to access specific parts of the API, e.g. changing user data. Whenever an access token is expired or doesn't exist, the refresh token should be used to get a new access token.

#### High-level example
User logins with username:uname and password:hunter1  
app sends request to server GET url:/auth/refreshtoken?username=uname&password=hunter1  
server responds with a string which is the refresh token, we can denote as refreshtoken  
app sends request to server GET url:/auth/accesstoken Headers:{Authorization: refreshtoken}  
server responds with a string accesstoken  
app sends request to server for some resource, say url:/user/data Headers:{Authorization: accesstoken}  
server responds with data  
app sends another request  
server says token expired  
app sends refresh token for another accesstoken, gets new accesstoken  
app sends another request for data  
