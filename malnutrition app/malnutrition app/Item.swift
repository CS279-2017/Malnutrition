//
//  Item.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/6/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation

//Generic object that superclasses Disease, BodyPart
class Item{
    var type:String? //can take on values: "Root, Symptom", "Body Part", "Action", "Question, or nil"
    var title:String?
    var description:String?
    var images: [String] = [String]();
    var nextItems:[Item] = [Item](); //items that are linked to this item (i.e these items will be displayed when this item is clicked)
    var options: [String] = [String]();
    var optionsSelectedIndex :Int?
    
    var value:String?
    
    var switched = false;

    init(){
    
    }
    
    init(type: String, title:String?, description: String?, images: [String], nextItems: [Item], options:[String]){
        self.type = type;
        self.title = title;
        self.description = description;
        self.images = images;
        self.nextItems = nextItems;
        self.options = options;
    }
    
    func setValue(value: String){
        self.value = value;
        switched = true;
    }
    
    func toggleSwitch(){
        switched = !switched;
    }
    
    func toString() -> String{
        var retString = "";
        if(switched == true){
            if(title != nil){
                retString += (title! + ": " + "\n");
            }
//            if(description != nil){
//                retString += (description! + "\n");
//            }
            if(optionsSelectedIndex != nil){
                retString += (options[optionsSelectedIndex!] + "\n");
            }
            if(value != nil){
                retString += (value! + "\n");
            }
            if(retString != ""){
                retString += "\n";
            }
        }
        for item in nextItems{
            retString += item.toString();
        }
        return retString;
    }
    
    func toJson() -> String?{
        
        let dictionary:[String:Any] = [
         "type":type, //can take on values: "Root, Symptom", "Body Part", "Action", "Question, or nil"
        "title":title,
        "description":description,
        "images":images,
        "nextItems": nextItems,
        "options": options,
        "optionsSelectedIndex": optionsSelectedIndex,
        "value":value,
        "switched":switched,
        ]
        var json:String?
        do {
            json = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) as? String
        } catch {
            print(error.localizedDescription)
        }
        return json
    }
    
    func switchOffAllItems(){
        switched = false;
        optionsSelectedIndex = nil;
        value = nil;
        for item in nextItems{
            item.switchOffAllItems();
        }
    }
}
