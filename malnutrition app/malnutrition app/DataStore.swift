//
//  DataStore.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/3/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation

//Singleton that manages all of the data used by the app
class DataStore{
    //stores the shared singleton instance of the DataStore class
    static var sharedInstance: DataStore? = nil;
    
    //get the singleton instance if it exists, otherwise call constructor and make an instance
    static func get() -> DataStore{
        if(sharedInstance == nil){
            sharedInstance = DataStore();
        }
        return sharedInstance!;
    }
    
    //Constructor for DataStore, called by get() function, never called outside of DataStore class
    private init(){
        
    }

}
