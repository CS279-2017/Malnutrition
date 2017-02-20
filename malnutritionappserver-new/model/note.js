function Note(options){
    this.title = options.title //String
    this.json = options.json //Json object string
    this.creationTime = options.creationTime ? options.creationTime : new Date().getTime(); //integer in milliseconds since 1970
}

User.prototype = {
    constructor: User,
}