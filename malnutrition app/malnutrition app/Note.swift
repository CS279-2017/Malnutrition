//
//  Note.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import SwiftyJSON
import Foundation

class Note: NSObject, NSCoding{
    var uuid:String;
    var title:String
    var textContent:String = "";
    var dateCreated:Date;
    var dateLastEdited: Date?;
    var examRootItem:Item?
    var assessmentRootItem: Item?
    
    init(title:String){
        self.uuid = UUID().uuidString
        self.title = title;
        self.dateCreated = Date();
//        self.dateLastEdited = Date();
    }
    
    init(title:String, text: String){
        self.uuid = UUID().uuidString
        self.title = title;
        self.textContent = text;
        self.dateCreated = Date();
//        self.dateLastEdited = Date();
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.uuid, forKey: "uuid");
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.textContent, forKey: "textContent")
        aCoder.encode(self.dateCreated, forKey: "dateCreated");
        aCoder.encode(self.dateLastEdited, forKey: "dateLastEdited");
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.uuid = aDecoder.decodeObject(forKey: "uuid") as! String;
        self.title = aDecoder.decodeObject(forKey: "title") as! String;
        self.textContent = aDecoder.decodeObject(forKey: "textContent") as! String
        self.dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date;
        self.dateLastEdited = aDecoder.decodeObject(forKey: "dateLastEdited") as! Date?;
    }
    
    func toJson()->String?{
        let dictionary =
            ["uuid": uuid,
             "title": title,
             "textContent": textContent,
             "dateCreated": String(describing: dateCreated),
             "dateLastEdited": String(describing: dateLastEdited),
             "examJson":examRootItem?.toJson(),
             "assessmentJSon":assessmentRootItem?.toJson(),
            ]

        var json:String?
        do {
            json = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) as? String
        } catch {
            print(error.localizedDescription)
        }
        return json
    }
    
}
