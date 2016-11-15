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
    
    
    var rootItem:Item = Item(type: "Root", title: nil, description: nil, images: [String](), nextItems: [Item]());
    
    private static let archiveURL: NSURL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask);
        let documentDirectory = documentsDirectories.first!.appendingPathComponent("noteBook.archive");
        return documentDirectory as NSURL
    }()
    
    var noteBook:NoteBook = NoteBook();
    
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
        if let unarchivedObject = (NSKeyedUnarchiver.unarchiveObject(withFile: DataStore.archiveURL.path!)){
            noteBook = unarchivedObject as! NoteBook;
        }
    
    }
    
    func parseJson(jsonString:String){
        if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
            let json = JSON(data: dataFromString);
//            for (index,subJson):(String, JSON) in json {
//                var item = Item();
//                item.text = json[index]["text"].string!;
//            }
            let i = json[0]["text"].string
            print(i);
            buildItemDirectory(parent: rootItem, json: json)
        }
    }
    
    func buildItemDirectory(parent: Item, json:JSON){
        let newItem = Item();
        newItem.type = json["type"].string
        newItem.title = json["title"].string
        newItem.description = json["description"].string
        //if the images array is not empty then copy all the image urls into a string array
        if let imageArray = json["images"].array{
            for json in imageArray{
                newItem.images.append(json.string!)
            }
        }
        //if nextItems array not empty recursively call the buildItemDirectory function on every item
        if let nextItem = json["nextItems"].array {
            if(nextItem.count > 0){
                for next in nextItem{
                    buildItemDirectory(parent: newItem, json: next)
                }
            }
        }
        parent.nextItems.append(newItem);
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
    
    //save user inform stored inside dataStore
    func save() -> Bool{
        return NSKeyedArchiver.archiveRootObject(noteBook, toFile: DataStore.archiveURL.path!)
    }
    
//    func makeNote(title:String, text:String){
//        let note = Note(title: title);
//        note.text = text;
//        
//    }
    
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
