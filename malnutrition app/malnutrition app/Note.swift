//
//  Note.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation

class Note: NSObject, NSCoding{
    var uuid:String;
    var title:String
    var text:String = "";
    var dateCreated:Date;
    var examRootItem:Item?
    var assessmentRootItem: Item?
    
    init(title:String){
        self.uuid = UUID().uuidString
        self.title = title;
        self.dateCreated = Date();
    }
    
    init(title:String, text: String){
        self.uuid = UUID().uuidString
        self.title = title;
        self.text = text;
        self.dateCreated = Date();
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.uuid, forKey: "uuid");
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.text, forKey: "text")
        aCoder.encode(self.dateCreated, forKey: "dateCreated");
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.uuid = aDecoder.decodeObject(forKey: "uuid") as! String;
        self.title = aDecoder.decodeObject(forKey: "title") as! String;
        self.text = aDecoder.decodeObject(forKey: "text") as! String
        self.dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date;
    }
    
}
