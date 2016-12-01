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
    }
    
    func toggleSwitch(){
        switched = !switched;
    }
    
    func toString() -> String{
        var retString = "";
        if(switched == true){
            if(title != nil){
                retString += ("Title: " + title! + "\n");
            }
            if(description != nil){
                retString += ("Description: " + description! + "\n");
            }
            if(optionsSelectedIndex != nil){
                retString += ("Condition: " + options[optionsSelectedIndex!] + "\n");
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
    
    func switchOffAllItems(){
        switched = false;
        optionsSelectedIndex = nil;
        value = nil;
        for item in nextItems{
            item.switchOffAllItems();
        }
    }
}
