//
//  DataStore.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/3/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation

import SwiftyJSON

//Singleton that manages all of the data used by the app
class DataStore{
    //stores the shared singleton instance of the DataStore class
    static var sharedInstance: DataStore? = nil;
    
    var itemsDirectory:[Item] = [Item]();
    
    //get the singleton instance if it exists, otherwise call constructor and make an instance
    static func get() -> DataStore{
        if(sharedInstance == nil){
            sharedInstance = DataStore();
        }
        return sharedInstance!;
    }
    
    private init(){
        //Constructor for DataStore, called by get() function, never called outside of DataStore class
        //read the string from the text file that contains the item directory structure
        let stringFromFile = readStringFromFile(fileName: "data")
        var parsedJsonObject = parseJson(jsonString: stringFromFile);
        
    }
    
    func parseJson(jsonString:String){
        if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
        }
    }
    
    
    func readStringFromFile(fileName: String) -> String{
        
        let path = Bundle.main.path(forResource: fileName, ofType: "txt")
        do{
            let text = try String(contentsOfFile: path!, encoding: String.Encoding.utf8);
            print(text)
            return text;
        }catch{
        
        }
        return "";
    }
    
//        let path = Bundle.main.path( forResource: "data", ofType: "txt");
//
////        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
////            
////            let path = dir.appendingPathComponent(fileName)
//        
//            //writing
////            do {
////                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
////            }
////            catch {/* error handling here */}
//            
//            //reading
//            do {
//                String(contentsOf: path!,
//                let text2 = try String(contentsOf: URL(path!), encoding: String.Encoding.utf8)
//                return text2;
//            }
//            catch {
//            }
//        }
//        return "";

}
