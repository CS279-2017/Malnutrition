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
    
    
    var rootItemExamination:Item = Item(type: "Root", title: nil, description: nil, images: [String](), nextItems: [Item](), options: [String]());
    
    var rootItemAssessmentQuiz:Item = Item(type: "Root", title: nil, description: nil, images: [String](), nextItems: [Item](), options: [String]());

    
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
        let examinationJson = readStringFromFile(fileName: "siruis json")
        let quizAssessmentJson = readStringFromFile(fileName: "assessment_quiz");
        parseJson(jsonString: examinationJson, root:rootItemExamination);
        parseJson(jsonString: quizAssessmentJson, root: rootItemAssessmentQuiz);
        if let unarchivedObject = (NSKeyedUnarchiver.unarchiveObject(withFile: DataStore.archiveURL.path!)){
            noteBook = unarchivedObject as! NoteBook;
        }
    
    }
    
    func parseJson(jsonString:String, root: Item){
        if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
            let json = JSON(data: dataFromString);
//            for (index,subJson):(String, JSON) in json {
//                var item = Item();
//                item.text = json[index]["text"].string!;
//            }
//            let i = json[0]["text"].string
//            print(i);
            buildItemDirectory(parent: root, json: json)
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
        if let options = json["options"].array{
            if(options.count > 0){
                for option in options{
                    newItem.options.append(option.string!)
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
    
    func error_handler(error: String){
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    func examinationNoteText() -> String{
        return "Review Of Symptoms:\n" + DataStore.get().rootItemExamination.toString() + "\n" + "Assessment Quiz:\n" + DataStore.get().rootItemAssessmentQuiz.toString();
    }

}

extension UIApplication {
    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
