//
//  UserData.swift
//  mealplanappiOS
//
//  Created by Bowen Jin on 11/9/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation
import UIKit

//UserData stores data persistent data about to user such as email_address and password as well as userId.
class UserData:NSObject, NSCoding{
    
    static var sharedInstance: UserData? = nil;
    //    var locationSubscribers = [String: ((String) -> ())]();
    
    private static let archiveURL: NSURL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask);
        let documentDirectory = documentsDirectories.first!.appendingPathComponent("userData.archive");
        return documentDirectory as NSURL
    }()
    
    var email_address: String? = nil
    
    var userId: String? = nil;
    var password: String? = nil;
    var device_token: String? = nil;
    
//    var venmo_id: String? = nil
//    var location: Location?
    var profile_picture: UIImage?
    
    var first_name: String? = nil;
    var last_name: String? = nil;
    
    var authKey: String? = "";
    
    
    private override init() {
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.email_address, forKey: "email_address")
        aCoder.encode(self.userId, forKey: "userId")
        aCoder.encode(self.password, forKey: "password")
//        aCoder.encode(self.venmo_id, forKey: "venmo_id")
        aCoder.encode(self.profile_picture, forKey: "profile_picture");
        aCoder.encode(self.first_name, forKey: "first_name");
        aCoder.encode(self.last_name, forKey: "last_name");
        aCoder.encode(self.device_token, forKey: "device_token");
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.email_address = aDecoder.decodeObject(forKey: "email_address") as? String
        self.userId = aDecoder.decodeObject(forKey: "userId") as? String
        self.password = aDecoder.decodeObject(forKey: "password") as? String
//        self.venmo_id = aDecoder.decodeObject(forKey: "venmo_id") as? String
        self.profile_picture = aDecoder.decodeObject(forKey: "profile_picture") as? UIImage
        self.first_name = aDecoder.decodeObject(forKey: "first_name") as? String
        self.last_name = aDecoder.decodeObject(forKey: "last_name") as? String
        self.device_token = aDecoder.decodeObject(forKey: "device_token") as? String
    }
    
    private static func save() -> Bool{
        return NSKeyedArchiver.archiveRootObject(sharedInstance, toFile: UserData.archiveURL.path!)
    }
    
    static func get() -> UserData?{
        if(sharedInstance != nil){
            return sharedInstance;
        }
        else{
            sharedInstance = NSKeyedUnarchiver.unarchiveObject(withFile: UserData.archiveURL.path!) as? UserData
            return sharedInstance
        }
    }
    
    static func set(authKey: String){
        if(sharedInstance == nil){
            sharedInstance = UserData();
        }
        sharedInstance?.authKey = authKey;
    }
    static func set(userId: String){
        if(sharedInstance == nil){
            sharedInstance = UserData();
        }
        sharedInstance?.userId = userId;
    }
    
    static func set(user: User){
        if(sharedInstance == nil){
            sharedInstance = UserData();
        }
        sharedInstance?.userId = user._id;
        sharedInstance?.first_name = user.first_name
        sharedInstance?.last_name = user.last_name;
        sharedInstance?.email_address = user.email_address;
//        sharedInstance?.venmo_id = user.venmo_id
        sharedInstance?.profile_picture = user.profile_picture
        
        if(!UserData.save()){
            print("Failed to save UserData");
        }
        else{
            print("Saved userData")
        }
    }
    
    
    static func set(password: String){
        if(sharedInstance == nil){
            sharedInstance = UserData();
        }
        sharedInstance?.password = password;
        if(!UserData.save()){
            print("Failed to save UserData");
        }
        else{
            print("Saved userData")
        }
    }
    
//    static func set(venmo_id: String?){
//        if(sharedInstance == nil){
//            sharedInstance = UserData();
//        }
//        sharedInstance?.venmo_id = venmo_id;
//        if(!UserData.save()){
//            print("Failed to save UserData");
//        }
//        else{
//            print("Saved userData")
//        }
//        
//    }
    
    static func set(profile_picture: UIImage){
        if(sharedInstance == nil){
            sharedInstance = UserData();
        }
        sharedInstance?.profile_picture = profile_picture;
        if(!UserData.save()){
            print("Failed to save UserData");
        }
        else{
            print("Saved userData")
        }
    }
    
    //    static func set(first_name: String, last_name: String){
    //        if(sharedInstance == nil){
    //            sharedInstance = UserData();
    //        }
    //        sharedInstance?.first_name = first_name;
    //        sharedInstance?.last_name = last_name;
    //        if(!UserData.save()){
    //            print("Failed to save UserData");
    //        }
    //        else{
    //            print("Saved userData")
    //        }
    //    }
    static func set(device_token: String){
        if(sharedInstance == nil){
            sharedInstance = UserData();
        }
        sharedInstance?.device_token = device_token;
        print("setting device_token:" + device_token)
        if(!UserData.save()){
            print("Failed to save device_token");
        }
        else{
            print("Saved device_token")
        }
    }
    
    static func clear(){
        //clears every field except for device_token which must be preserved
        let device_token = sharedInstance?.device_token
        sharedInstance = UserData();
        sharedInstance?.device_token = device_token;
        if(!UserData.save()){
            print("Failed to clear user data!");
        }
        else{
            print("Cleared user data!")
        }
    }
    
}

