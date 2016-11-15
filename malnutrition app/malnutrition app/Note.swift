//
//  Note.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation

class Note: NSObject, NSCoding{
    var title:String
    var text:String = "";
    var dateCreated:Date;
    
    init(title:String){
        self.title = title;
        self.dateCreated = Date();
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.text, forKey: "text")
        aCoder.encode(self.dateCreated, forKey: "dateCreated");
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String;
        self.text = aDecoder.decodeObject(forKey: "text") as! String
        self.dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date;
    }
    
}
