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
    var nextItems:[Item] = [Item](); //items that are linked to this item (i.e these items will be displayed when this item is clicked)
    var text:String = "";
    
    init(){
        
    }
    
    init(text:String, nextItems: [Item]){
        self.text = text;
        self.nextItems = nextItems; 
    }
    
    
    
}
