//
//  SurveyController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 2/26/17.
//  Copyright © 2017 Bowen Jin. All rights reserved.
//

import UIKit

class SurveyController: UITableViewController{
    
    @IBOutlet weak var submitButton: BaseButton!
    @IBOutlet weak var yearsInPracticeTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    var clinicianType: String?
    var vumcUnit: String?
    
    @IBOutlet weak var clinicianTypeLabel: UILabel!
    @IBOutlet weak var vumcUnitLabel: UILabel!
    
    var survey: Survey?;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        survey = UserData.get()?.survey
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
        firstNameTextField.text = UserData.get()?.firstName
        lastNameTextField.text = UserData.get()?.lastName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        clinicianTypeLabel.text = clinicianType
        vumcUnitLabel.text = vumcUnit
    }
    
    func submitButtonClicked(){
        guard let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else{
            DataStore.get().errorHandler(error: "Please enter your First Name");
            return;
        }
        guard let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else{
            DataStore.get().errorHandler(error: "Please enter your Last Name");
            return;
        }
        guard let yearsInPracticeString = yearsInPracticeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else{
            DataStore.get().errorHandler(error: "Please enter your Years In Practice");
            return;
        }
        guard let yearsInPractice = Int(yearsInPracticeString) else{
            DataStore.get().errorHandler(error: "Please enter a valid number for Years In Practice");
            return;
        }
//        survey?.firstName = firstName;
//        survey?.lastName = lastName;
//        survey?.yearsInPractice = yearsInPractice;
//        survey
        if(self.vumcUnit == nil){
            DataStore.get().errorHandler(error: "Please select your VUMC Unit");
            return;
        }
        if(self.clinicianType == nil){
            DataStore.get().errorHandler(error: "Please select your Clinician Type");
            return;
        }
        self.survey = Survey(firstName: firstName, lastName: lastName, vumcUnit: vumcUnit!, clinicianType: clinicianType!, yearsInPractice: yearsInPractice)
        
        if let survey = self.survey{
            UserData.set(survey: survey)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.popToMainController();
        }
        else{
            DataStore.get().errorHandler(error: "Invalid survey");
        }
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
//        
//        let cell = tableView.cellForRow(at: indexPath);
//        let identifier = cell?.reuseIdentifier;
//        let destinationVC = OptionsController();
//        destinationVC.identifier = identifier;
//        destinationVC.performSegue(withIdentifier: "surveyToOptions", sender: self)
//        // Create an instance of PlayerTableViewController and pass the variable
////        let destinationVC = PlayerTableViewController()
////        destinationVC.programVar = selectedProgram
//        
//        // Let's assume that the segue name is called playerSegue
//        // This will perform the segue and pre-load the variable for you to use
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let toViewController = segue.destination as? OptionsController {
            toViewController.identifier = segue.identifier;
            toViewController.parentController = self;
//            toViewController.survey = self.survey;
        }
//        if segue.identifier == "vumc" {
//            
//            
//        }
    }
    
}
