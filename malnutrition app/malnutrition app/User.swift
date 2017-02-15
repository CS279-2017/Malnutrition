//
//  User.swift
//  malnutrition app
//
//  Created by Bowen Jin on 2/6/17.
//  Copyright © 2017 Bowen Jin. All rights reserved.
//

class User{
    var _id: String?
    var first_name: String?
    var last_name: String?
    var email_address: String?
    
//    var venmo_id: String?
//    var location: Location?
    var profile_picture: UIImage?
    
    var creation_time: UInt64?
    var last_login_time: UInt64?
    
//    var buying_listing_ids: [String]?
//    var selling_listing_ids: [String]?
    
    var logged_in: Bool?
    
    init(){

    }
    
    init(dictionary: Dictionary<String, Any>){
        self._id = dictionary["_id"] as? String;
        self.first_name = dictionary["first_name"] as? String;
        self.last_name = dictionary["last_name"] as? String;
        self.email_address = dictionary["email_address"] as? String;
        
//        self.venmo_id = dictionary["venmo_id"] as? String
        
        if let data = dictionary["profile_picture"] as? Data{
            //            let data = profile_picture_string.data(using: String.Encoding.utf8.rawValue)
            self.profile_picture = UIImage(data: data)
        }
        
        self.creation_time = dictionary["creation_time"] as! UInt64;
        
        self.last_login_time = dictionary["last_login_time"] as? UInt64
        
//        self.buying_listing_ids = dictionary["buying_listing_ids"] as? [String]
//        
//        self.selling_listing_ids = dictionary["selling_listing_ids"] as? [String]
        
        self.last_login_time = dictionary["last_login_time"] as? UInt64;
        self.logged_in = dictionary["logged_in"] as? Bool
    }

}
