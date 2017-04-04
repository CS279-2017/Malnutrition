//bte = Bowen's Template Engine
var fs = require('fs');
var path = require('path');
var db = require('../db/db');

var i18n = require('i18n');

var dirPath;
function BowensTemplateEngine(){
    dirPath = path.join(__dirname,'../views/');
}

BowensTemplateEngine.prototype = {
    constructor: BowensTemplateEngine,
    render: function(filePath, callback, options) { // define the template engine
        var cookies;
        if(options) cookies = options.cookies;

        if(options.locale && cookies && cookies.language){
            options.locale.setLocale(cookies.language);
        }
        filePath = dirPath + filePath;
        fs.readFile(filePath, function (err, content) {
            if (err) return callback(err);
            content = content.toString();
            content = processHeader(content);
            content = processFooter(content);

            //processes is an array of processes that will run in order
            //each passing content to the next
            //each process takes 1 parameter, that is the content (i.e html)
            var processes = options ? (options.processes ? options.processes : []) : []
            for(var i=0; i < processes.length; i++){
                var process = processes[i];
                content = process(content);
                // content = processTable(content, charges);
            }
            
            processNavBar(content, path.basename(filePath, '.html'), function(processedContent){;
                processedContent = processInternationalization(processedContent, options.locale) //internationalization is last step
                callback(processedContent);
            }, cookies, options.locale);
        });
    },
}

function processHeader(content){
    var headerString =
        // '<meta charset="utf-8">' +
        // '<meta name="Description" CONTENT="Author: A.N. Author, Illustrator: P. Picture, Category: Books, Price:  £9.24, Length: 784 pages">' +
        // '<meta name="google-site-verification" content="+nxGUDJ4QpAZ5l9Bsjdi102tLVC21AIh5d1Nl23908vVuFHs34="/>' +
        // '<title>Example Books - high-quality used books for children</title>' +
        '<link rel="shortcut icon" type="image/x-icon" href="/images/favicon.ico" />'+
        '<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>' +
        '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">' +
        '<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>';
    return content.replace('#default-header#', headerString);
}
function processNavBar(content, basename, callback, cookies, locale) {
    var filePath = '/' + (basename == 'index' ? '' : basename);
    var options = [
        {filePath: '/', title: 'Home'},
        {filePath: '/buy', title: 'Buy'},
        {filePath: '/download', title: 'Download'},
        // {filePath: '/about', title: 'About'},
    ]
    // console.log("cookies:");
    // console.log(cookies)
    if(cookies && cookies.userId && cookies.authKey){
        db.users.authenticate(cookies.userId, cookies.authKey, function(user){
            var navBarString = generateNavBarString(user, locale);
            content = content.replace('#nav-bar#', navBarString)
            callback(content);
        }, function(error){
            var navBarString = generateNavBarString(null, locale);
            content = content.replace('#nav-bar#', navBarString)
            callback(content);
        })
    }
    else{
        var navBarString = generateNavBarString(null, locale);
        content = content.replace('#nav-bar#', navBarString)
        callback(content);
    }


    function generateNavBarString(user, locale){
        var string =
            '<div class="navbar navbar-default navbar-extra">'+
                '<div class="container">'+
                    '<div class="navbar-header">'+
                        '<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">'+
                        '<span class="icon-bar"></span>'+
                        '<span class="icon-bar"></span>'+
                        '<span class="icon-bar"></span>'+
                        '</button>'+
                        '<a class="navbar-brand" href="/">' +
                            '<img alt="Brand" style=" width:24px; height:24px; margin-bottom:10px; display: inline-block; " src="/images/logo64px.png">' +
                            // '<span style="display: inline-block;">  SeaTurtleVPN </span>' +
                        '</a>'+
                    '</div>'+
                    '<div class="navbar-collapse collapse">'+
                        '<ul class="nav navbar-nav">' +
                            generateSelectedBar(filePath) +
                        '</ul>'+
                            generateRightBar(user, locale) +
                    '</div>'+
                '</div>'+
            '</div>';
        var css =
            '<style>' +
                '.navbar{' +
                    'margin-bottom: 0;' +
                    'border-radius: 0;' +
                '}' +
            '</style>'

        return string + css;
    }

    function generateSelectedBar(filePath) {
        var retString = "";
        for (var i = 0; i < options.length; i++) {
            var option = options[i];
            if (option.filePath == filePath) {
                retString += '<li class="active"><a href="' + option.filePath + '">' + '<i18n-string>' + option.title + '</i18n-string>' + '<span class="sr-only">(current)</span></a></li>';
            }
            else {
                retString += '<li><a href="' + option.filePath + '">' + '<i18n-string>' + option.title + '</i18n-string>' + '</a></li>';
            }
        }
        return retString;
    }

    function generateRightBar(user, locale){
        var html =
            (user ?
                '<ul id="navbar-right" class="nav navbar-nav navbar-right">'+
                    '<li>' +
                        '<style>.language-button{margin-top: 10px;}</style>'+
                        '<button type="button" class="btn btn-default btn-sm language-button" onclick="languageButtonClicked()">' +
                            '<i18n-string>中文</i18n-string>' +
                        '</button>' +
                '   </li>'+
                    '<li class="dropdown">'+
                        '<a href="#" class="dropdown-toggle" data-toggle="dropdown">'+
                            user.email +
                        '<span class="caret"></span>'+
                        '</a>'+
                        '<ul class="dropdown-menu">'+
                            // '<li><a href="/bowen28">Profile</a></li>'+
                            '<li><a href="/user/purchases/"><i18n-string>My Purchases</i18n-string></a></li>'+

                            '<li class="divider"></li>'+
                            '<li><a href="/user/refer/"><i18n-string>Refer Friends</i18n-string></a></li>'+

                            '<li class="divider"></li>'+
                            // '<li><a href="/submissions/">My Submissions</a></li>'+
                            // '<li><a href="/progress/">My Progress</a></li>'+
                            // '<li><a href="/list/">My List</a></li>'+
                            // '<li><a href="/session/">Manage Sessions</a></li>'+
                            // '<li><a href="/notes/">My Notes</a></li>'+
                            // '<li><a href="/accounts/password/change/">Change Password</a></li>'+
                            // '<li class="divider"></li>'+
                            '<li id="dropdown-logout"><a href="/user/logout"><i18n-string>Logout</i18n-string></a></li>'+
                        '</ul>'+
                    '</li>'+
                '</ul>'
                :
                '<ul id="navbar-right" class="nav navbar-nav navbar-right navbar-form">'+
                    '<style>.language-button{margin-top: 2px;}</style>'+
                    '<button type="button" class="btn btn-default btn-sm language-button" onclick="languageButtonClicked()">' +
                    '<i18n-string>中文</i18n-string>' +
                    '</button>' + '  ' +
                    '<a class="btn btn-success" href="/register"><i18n-string>Register</i18n-string></a>'+ ' ' +
                    '<a class="btn btn-info" href="/login"><i18n-string>Login</i18n-string></a>'+
                '</ul>'
            )

        var javascript =
            '<script>' +
                '$("#dropdown-logout").on("click",function(e) {'+
                    'e.preventDefault();'+
                    '$.post("/user/logout", function(data){' +
                        'window.location.href = "/";'+
                    '})' +
                '});' +
                'function createCookie(name,value,days) {' +
                    'var expires = "";' +
                   'if (days) {' +
                        'var date = new Date();' +
                        'date.setTime(date.getTime() + (days*24*60*60*1000));' +
                        'expires = "; expires=" + date.toUTCString();' +
                    '}' +
                    'document.cookie = name + "=" + value + expires + "; path=/";' +
                '}' +
                'function readCookie(name) {' +
                    'var nameEQ = name + "=";' +
                    'var ca = document.cookie.split(";");' +
                    'for(var i=0;i < ca.length;i++) {' +
                        'var c = ca[i];' +
                        'while (c.charAt(0)==" ") c = c.substring(1,c.length);' +
                        'if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);' +
                    '}' +
                    'return null;' +
                '}' +
                'function languageButtonClicked(){'+
                    (locale.getLocale() == "zh" ?
                        'createCookie("language", "en"); location.reload(); ':
                        'createCookie("language", "zh"); location.reload(); ') +
                '}' +
            '</script>'

        return html + javascript;
    }
}

function processFooter(content){
    var year = new Date().getFullYear();
    var footerString =
        '<br><br><br>'+
        // '<div class="push"></div>' +
        '<footer class="footer">'+
        '<p>&copy; ' + year + ' SeaTurtleVPN</p>'+
        '</footer>'+
        '<style>' +
            '*{'+
                'margin: 0;'+
            '}'+
            'html, body {' +
                'height: 100%;'+
            '}' +
            '.main{' +
                'min-height: 100%;' +
                'height: auto !important;' +
                'height: 100%; ' +
                'margin: 0 auto -60px;' +
            '}' +
            '.footer, .push {' +
                'position: relative;'+
                'bottom: 0;'+
                'width: 100%;'+
                'height: 60px;' +
            '}'+
            '.footer {' +
                'background-color: #f5f5f5;'+
                'padding-top: 19px;' +
                ' color: #777;' +
                'padding-left: 19px;' +
                'border-top: 1px solid #e5e5e5' +
            '}' +
        '</style>';

    content = content.replace('#footer#', footerString);
    return content;
}

function processInternationalization(content, locale){
    var strings = content.match(/<i18n-string>(.*?)<\/i18n-string>/g).map(function(val){
        return val.replace(/<\/?i18n-string>/g,'');
    });

    for(var i=0; i<strings.length; i++){
        var string = strings[i];
        // console.log(i18n.getLocale());
        var translatedString = locale.__(string);
        // console.log('translatedString: ' + translatedString);
        content = content.replace('<i18n-string>'+string+'</i18n-string>', translatedString);
    }
    return content;
}



module.exports = new BowensTemplateEngine();


