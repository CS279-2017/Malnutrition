//
//  Survey.swift
//  malnutrition app
//
//  Created by Bowen Jin on 2/26/17.
//  Copyright © 2017 Bowen Jin. All rights reserved.
//

import Foundation

class Survey:NSObject, NSCoding{
    var uuid:String?
    var userId: String?
    var textContent:String? = "";
    var dateCreated:Date?;
    var dateLastEdited: Date?;
    
    var firstName: String?;
    var lastName: String?;
    var vumcUnit: String?;
    var clinicianType: String?;
    var yearsInPractice: Int?;
    
    var completed: Bool? = false
    
    
    init(firstName: String, lastName:String, vumcUnit:String, clinicianType:String, yearsInPractice:Int){
        self.uuid = UUID().uuidString
        self.userId = (UserData.get()?.userId!)!
        self.dateCreated = Date();
        
        self.firstName = firstName;
        self.lastName = lastName
        self.vumcUnit = vumcUnit;
        self.clinicianType = clinicianType;
        self.yearsInPractice = yearsInPractice;
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.uuid, forKey: "uuid");
        aCoder.encode(self.textContent, forKey: "textContent")
        aCoder.encode(self.dateCreated, forKey: "dateCreated");
        aCoder.encode(self.dateLastEdited, forKey: "dateLastEdited");
        
        aCoder.encode(self.firstName, forKey: "firstName");
        aCoder.encode(self.lastName, forKey: "lastName");
        aCoder.encode(self.vumcUnit, forKey: "vumcUnit");
        aCoder.encode(self.clinicianType, forKey: "clinicianType");
        aCoder.encode(self.yearsInPractice, forKey: "yearsInPractice");
        aCoder.encode(self.completed, forKey: "completed");

    }
    
    required init?(coder aDecoder: NSCoder) {
        self.uuid = aDecoder.decodeObject(forKey: "uuid") as? String;
        self.userId = aDecoder.decodeObject(forKey: "userId") as? String
        self.textContent = aDecoder.decodeObject(forKey: "textContent") as? String
        self.dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as? Date;
        self.dateLastEdited = aDecoder.decodeObject(forKey: "dateLastEdited") as? Date;
        
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as? String;
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as? String;
        self.vumcUnit = aDecoder.decodeObject(forKey: "vumcUnit") as? String;
        self.clinicianType = aDecoder.decodeObject(forKey: "clinicianType") as? String;
        self.yearsInPractice = aDecoder.decodeObject(forKey: "yearsInPractice") as? Int;
        
        self.completed = aDecoder.decodeObject(forKey: "completed") as? Bool;
    }
    
    func toDictionary() -> Dictionary<String, Any>{
        return [
            "preferredFirstName": firstName,
            "preferredLastName":lastName,
            "vumcUnit": vumcUnit,
            "clinicianType": clinicianType,
            "yearsInPractice": yearsInPractice,
        ];
    }
}
