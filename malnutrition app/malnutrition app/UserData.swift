//
//  UserData.swift
//  mealplanappiOS
//
//  Created by Bowen Jin on 11/9/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation
import UIKit

//UserData stores data persistent data about to user such as email and password as well as userId.
class UserData:NSObject, NSCoding{
    
    static var sharedInstance: UserData? = nil;
    //    var locationSubscribers = [String: ((String) -> ())]();
    
    private static let archiveURL: NSURL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask);
        let documentDirectory = documentsDirectories.first!.appendingPathComponent("userData.archive");
        return documentDirectory as NSURL
    }()
    
    var email: String? = nil
    
    var userId: String? = nil;
    var password: String? = nil;
    var device_token: String? = nil;
    
//    var venmo_id: String? = nil
//    var location: Location?
    var profilePicture: UIImage?
    
    var firstName: String? = nil;
    var lastName: String? = nil;
    
    var authKey: String? = "";
    
    var surveyComplete: Bool? = false
    
    var survey: Survey?
    var noteBook: NoteBook?
    
    
    private override init() {
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.password, forKey: "password")
        
        aCoder.encode(self.userId, forKey: "userId")
        aCoder.encode(self.authKey, forKey: "authKey");
        
        aCoder.encode(self.firstName, forKey: "firstName");
        aCoder.encode(self.lastName, forKey: "lastName");
        
        aCoder.encode(self.survey, forKey: "survey");
        aCoder.encode(self.noteBook, forKey: "noteBook")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.password = aDecoder.decodeObject(forKey: "password") as? String

        self.userId = aDecoder.decodeObject(forKey: "userId") as? String
        self.authKey = aDecoder.decodeObject(forKey: "authKey") as? String
        
        
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as? String
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as? String
        
        self.survey = aDecoder.decodeObject(forKey: "survey") as? Survey
        self.noteBook = aDecoder.decodeObject(forKey: "noteBook") as? NoteBook
    }
    
    static func save() -> Bool{
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
    static func set(email: String){
        if(sharedInstance == nil){
            sharedInstance = UserData();
        }
        sharedInstance?.email = email
        if(!UserData.save()){
            print("Failed to save UserData");
        }
        else{
            print("Saved userData")
        }
    }
    
    static func set(firstName: String, lastName: String){
        if(sharedInstance == nil){
            sharedInstance = UserData();
        }
        sharedInstance?.firstName = firstName;
        sharedInstance?.lastName = lastName;
        if(!UserData.save()){
            print("Failed to save UserData");
        }
        else{
            print("Saved userData")
        }
    }
    
    static func deleteNote(note: Note, callback: (() -> Void)?, errorHandler: ((String)->Void)?){
        if(sharedInstance == nil){
            sharedInstance = UserData();
        }
        if(sharedInstance?.noteBook == nil){
            sharedInstance?.noteBook = NoteBook();
        }
        sharedInstance?.noteBook?.deleteNote(note: note);
        if(!UserData.save()){
            print("Failed to save UserData");
            errorHandler!("Failed to delete note")
        }
        else{
            print("deleted note")
            callback!();
        }
    }

    static func addNote(note: Note, callback: (() -> Void)?, errorHandler: ((String)->Void)?){
        if(sharedInstance == nil){
            sharedInstance = UserData();
        }
        if(sharedInstance?.noteBook == nil){
            sharedInstance?.noteBook = NoteBook();
        }
        sharedInstance?.noteBook?.addNote(note: note);
        if(!UserData.save()){
            print("Failed to save UserData");
            errorHandler!("Failed to add note")
        }
        else{
            print("added note")
            callback!();
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
    
    static func set(profilePicture: UIImage){
        if(sharedInstance == nil){
            sharedInstance = UserData();
        }
        sharedInstance?.profilePicture = profilePicture;
        if(!UserData.save()){
            print("Failed to save UserData");
        }
        else{
            print("Saved userData")
        }
    }

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
    
    static func set(survey: Survey){
        if(sharedInstance == nil){
            sharedInstance = UserData();
        }
        sharedInstance?.survey = survey;
        if(!UserData.save()){
            print("Failed to save survey");
        }
        else{
            print("Saved survey")
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

