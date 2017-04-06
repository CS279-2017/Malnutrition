module.exports = {
  development: {
      db: 'mongodb://localhost:27017/SeaTurtleVPN',
      port: 3000,
      domain: 'http://localhost:3000',
      maxNumberOfDownloads: 3,
      maxNumberOfDevices: 3,
      xauthUserFilePath: '/files/userFile.txt',
      l2tpUserFilePath: '/files/l2tpUserFile.txt',
      removeExpiredUsersInterval: 1000*60*1,
      bonusTimeReferral: 1000*60*60*24*10, //10 days
      bonusTimeSubscription: 0,
      trialTime: 1000*60*60*24*10, //10 days
      resetPasswordLinkExpirationTime: 1000*60*60,

  },
    test: {
    db: 'mongodb://localhost:27017/SeaTurtleVPN',
    port: 3000,
    domain: 'http://localhost:3000',
    maxNumberOfDownloads: 3,
    maxNumberOfDevices: 3,
    xauthUserFilePath: '/files/userFile.txt',
        l2tpUserFilePath: '/files/l2tpUserFile.txt',
        removeExpiredUsersInterval: 1000*60*1, //5 seconds
        bonusTimeReferral: 1000*60*60*24*10, //10 days
        bonusTimeSubscription: 0,
        trialTime: 1000*60*60*24*10, //10 days
        resetPasswordLinkExpirationTime: 1000*60*60,
    },
  production: {
    db: 'mongodb://bowenjin:chocho513@ds119380.mlab.com:19380/bowenvpn',
    port: 80,
    domain: 'https://www.SeaTurtleVPN.com',
    maxNumberOfDownloads: 3,
    maxNumberOfDevices: 3,
    xauthUserFilePath: '../etc/ipsec.d/passwd',
      l2tpUserFilePath: '../etc/ppp/chap-secrets',
      removeExpiredUsersInterval: 1000*60*1,
      bonusTimeReferral: 1000*60*60*24*10, //10 days
      bonusTimeSubscription: 0,
      trialTime: 1000*60*60*24*10, //10 days
      resetPasswordLinkExpirationTime: 1000*60*60,
  }
}[process.env.NODE_ENV || 'development'];
