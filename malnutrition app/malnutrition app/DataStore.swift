//
//  DataStore.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/3/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation
import Firebase

import SwiftyJSON

//Singleton that manages all of the data used by the app
class DataStore{
    //stores the shared singleton instance of the DataStore class
    static var sharedInstance: DataStore? = nil;
    
//    let serverUrl = "http://ec2-35-163-70-13.us-west-2.compute.amazonaws.com:3000";
    let serverUrl = "http://10.66.134.47:3000"
//    let serverUrl = "https://nutriscreen.herokuapp.com"
    
    let vumcUnitOptions = ["Geriatrics", "General Medical","General Surgical"]
    
    let clinicianTypeOptions = ["Attending Physician", "Resident", "Nurse Practitioner", "Physician Assistant", "Registered Nurse","Dietician"]
    
    
    var rootItemExamination:Item = Item(type: "Root", title: nil, description: nil, images: [String](), nextItems: [Item](), options: [String]());
    
    var rootItemAssessmentQuiz:Item = Item(type: "Root", title: nil, description: nil, images: [String](), nextItems: [Item](), options: [String]());

    
//    private static let archiveURL: NSURL = {
//        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask);
//        let documentDirectory = documentsDirectories.first!.appendingPathComponent("noteBook.archive");
//        return documentDirectory as NSURL
//    }()
    
    var noteBook:NoteBook = NoteBook();
    
    var authKey:String = "";
    
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
//        if let unarchivedObject = (NSKeyedUnarchiver.unarchiveObject(withFile: DataStore.archiveURL.path!)){
//            noteBook = unarchivedObject as! NoteBook;
//
//        }
    
    }
    
    func parseJson(jsonString:String, root: Item){
        if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
            let json = JSON(data: dataFromString);
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
    
    func login(email: String, password: String, callback: (() -> Void)?, errorHandler: ((String)->Void)?){
        let request = HTTPRequest(url: serverUrl+"/user/login", method: "POST", parameters: ["email":email, "password":password]);
        request.send(callback: {dictionary in
            let dictionary = dictionary as! Dictionary<String, String>
            //save authKey and userId that are passed back
            UserData.set(authKey: dictionary["authKey"]!);
            UserData.set(userId: dictionary["userId"]!);
            UserData.set(email: email);
            callback?();
        }, errorHandler: {error in
            DataStore.get().errorHandler(error: error);
        })
    }
    
    func register(email: String, password: String, callback: (() -> Void)?, errorHandler: ((String)->Void)?){
        let request = HTTPRequest(url: serverUrl+"/user/register", method: "POST", parameters: ["email":email, "password":password]);
        request.send(callback: {dictionary in
            UserData.set(email: email);
            //successful registration
            //show login screen?
            callback?();
        }, errorHandler: {error in
            DataStore.get().errorHandler(error: error);
        })
    }
    
    func authenticate(callback: (()->())?, errorHandler: ((String)->())?){
        guard let authKey = UserData.get()?.authKey else {self.errorHandler(error: "No authKey saved"); return;}
        guard let userId = UserData.get()?.userId else {self.errorHandler(error: "No userId saved"); return;}
        let request = HTTPRequest(url: serverUrl+"/user/authenticate", method: "POST", parameters: ["authKey":authKey, "userId":userId]);
        request.send(callback: {dictionary in
            //successful authentication
            callback?();
        }, errorHandler: {error in
            //unsuccessful authentication (show login?)
            //            DataStore.get().errorHandler(error: error);
            errorHandler?(error);
        })
    }
    
    func logout(callback: (()->())?, errorHandler: ((String)->())?){
        guard let authKey = UserData.get()?.authKey else {self.errorHandler(error: "No authKey saved"); return;}
        guard let userId = UserData.get()?.userId else {self.errorHandler(error: "No userId saved"); return;}
        let request = HTTPRequest(url: serverUrl+"/user/logout", method: "POST", parameters: ["authKey":authKey, "userId":userId]);
        request.send(callback: {dictionary in
            //successful authentication
            callback?();
        }, errorHandler: {error in
            //unsuccessful authentication (show login?)
            DataStore.get().errorHandler(error: error);
        })
    }
    
    func sendSurvey(survey: Survey, callback: (()->())?, errorHandler: ((String)->())?){
        guard let userId = UserData.get()?.userId else { DataStore.get().errorHandler(error: "No userId"); return;
        }
        guard let authKey = UserData.get()?.authKey else { DataStore.get().errorHandler(error: "No authKey"); return;
        }
        var surveyJson:String?
        do {
            surveyJson = try JSONSerialization.data(withJSONObject: survey.toDictionary(), options: .prettyPrinted).base64EncodedString();

        } catch {
            self.errorHandler(error: error.localizedDescription)
        }

        let request = HTTPRequest(url: serverUrl+"/user/survey", method: "POST",parameters: ["userId":userId, "authKey":authKey, "survey": surveyJson!]);
        request.send(callback: {dictionary in
//            let dictionary = dictionary as! Dictionary<String, String>
            callback?();
        }, errorHandler: {error in
            DataStore.get().errorHandler(error: error);
        })
    }

    
    func getJson(type: String, callback: ((String) -> Void)?, errorHandler: ((String)->Void)?){
        var request = URLRequest(url: URL(string: serverUrl + "/get_json")!)
        request.httpMethod = "POST"
//        let postString = "id=13&name=Jack"
        let postString = "type=" + type;
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                if(errorHandler != nil){
                    errorHandler!(String(describing: error));
                }
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                let error = "statusCode should be 200, but is \(httpStatus.statusCode)"
                if(errorHandler != nil){
                    errorHandler!(error);
                }
                print(error)
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            if let dataFromString = responseString?.data(using: .utf8, allowLossyConversion: false) {
                let json = JSON(data: dataFromString);
                let jsonString = json["data"]["json"].string
                if let jsonString = jsonString{
                    if(callback != nil){
                        callback!(jsonString)
                    }
                }
                else{
                    DataStore.get().errorHandler(error: "Could not get Json from server");
                }
                
            }
            else{
                errorHandler!("invalid json string");
            }
            
        }
        task.resume()
    }
    
    
    func readStringFromFile(fileName: String) -> String{
        
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        do{
            let text = try String(contentsOfFile: path!, encoding: String.Encoding.utf8);
            print(text)
            return text;
        }catch{
        
        }
        return "";
    }
    
    //save user inform stored inside dataStore
//    func save() -> Bool{
//        return NSKeyedArchiver.archiveRootObject(noteBook, toFile: DataStore.archiveURL.path!)
//    }
    
    func errorHandler(error: String){
        var error = error;
        DispatchQueue.main.async {
            if error.contains("Optional(Error"){
                error = "An error occured!";
            }
            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            }
            alertController.addAction(okAction)
            
            UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
            let eventName = (error + "error").toFireBaseEventName()
            FIRAnalytics.logEvent(withName: eventName, parameters: [:]);
        }
    }
    
    func getNoteString() -> String{
        return "Review Of Symptoms:\n" + DataStore.get().rootItemExamination.toString() + "\n" + "Assessment Quiz:\n" + DataStore.get().rootItemAssessmentQuiz.toString();
    }
    
    func clearNote(){
        rootItemAssessmentQuiz.switchOffAllItems();
        rootItemExamination.switchOffAllItems();
    }
    
    func loadSymptoms(){
        getJson(type: "symptoms", callback: { symptomsJson in
            print("Loaded Symptoms from server!")
            self.parseJson(jsonString: symptomsJson, root:self.rootItemExamination);
            AppDelegate.loadedSymptoms = true;
            }, errorHandler: { error in
                print("Loaded Symptoms from file!")
                let symptomsJson = self.readStringFromFile(fileName: "symptoms")
                self.parseJson(jsonString: symptomsJson, root:self.rootItemExamination);
                AppDelegate.loadedSymptoms = true;
        });
    }
    
    func loadAssessment(){
        getJson(type: "assessment", callback: { assessmentJson in
            print("Loaded Assessments from server!")
            print(assessmentJson);
            self.parseJson(jsonString: assessmentJson, root:self.rootItemAssessmentQuiz);
            AppDelegate.loadedAssessments = true;
            }, errorHandler: { error in
                print("Loaded Assessments from file!")
                let assessmentJson = self.readStringFromFile(fileName: "assessment")
                self.parseJson(jsonString: assessmentJson, root:self.rootItemAssessmentQuiz);
                AppDelegate.loadedAssessments = true;
        });
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
