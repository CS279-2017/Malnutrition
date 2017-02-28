//
//  ExaminationController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 12/1/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//


import UIKit

class ExaminationController: BaseController{
    
    @IBOutlet weak var symptomsButton: BaseButton!
    
    @IBOutlet weak var assessmentButton: BaseButton!
    
    @IBOutlet weak var clearNoteButton: BaseButton!
    @IBOutlet weak var makeNoteButton: BaseButton!
    override func viewDidLoad() {
        super.viewDidLoad();
        symptomsButton.addTarget(self, action: #selector(symptomsButtonClicked(sender:)), for: .touchUpInside)
        assessmentButton.addTarget(self, action: #selector(assessmentButtonClicked(sender:)), for: .touchUpInside)
        
        makeNoteButton.addTarget(self, action: #selector(makeNoteButtonClicked(sender:)), for: .touchUpInside)
        
        clearNoteButton.addTarget(self, action: #selector(clearNoteButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        
//        symptomsButton.layer.borderWidth = 1;
//        symptomsButton.layer.borderColor = symptomsButton.tintColor.cgColor
//        
//        assessmentButton.layer.borderWidth = 1;
//        assessmentButton.layer.borderColor = assessmentButton.tintColor.cgColor;
        
        self.screenName = "Examination Screen"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        AppDelegate.loadedAssessments = false;
        AppDelegate.loadedSymptoms = false;
    }
    
    func assessmentButtonClicked(sender: BaseButton){
        DataStore.get().loadAssessment();
        while(AppDelegate.loadedAssessments != true){
            
        }
        let rootItem = DataStore.get().rootItemAssessmentQuiz;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AssessmentController") as! AssessmentController
        controller.setItem(rootItem: rootItem.nextItems[0]);
        self.navigationController?.pushViewController(controller, animated: true);
    }
    
    func symptomsButtonClicked(sender:BaseButton){
        DataStore.get().loadSymptoms();
        while(AppDelegate.loadedSymptoms != true){
            
        }
        let rootItem = DataStore.get().rootItemExamination;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemTableController") as! ItemTableController
        print(rootItem.nextItems[0]);
        controller.setItem(item: rootItem.nextItems[0]);
        self.navigationController?.pushViewController(controller, animated: true);
    }
    
    func makeNoteButtonClicked(sender: BaseButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NoteEditController") as! NoteEditController
        let note = Note(title: "", text: DataStore.get().getNoteString());
        controller.setNote(note: note, isEditingExisting: false);
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func clearNoteButtonClicked(sender: BaseButton){
        let alertController = UIAlertController(title: "Clear Note", message: "Are you sure you want to clear this note?", preferredStyle: UIAlertControllerStyle.alert)
        let clearAction = UIAlertAction(title: "Clear", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
            DataStore.get().clearNote();

        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(clearAction)
        alertController.addAction(cancelAction)
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }

}
