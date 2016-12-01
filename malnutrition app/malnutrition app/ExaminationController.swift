//
//  ExaminationController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 12/1/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class ExaminationController: UIViewController{
    
    @IBOutlet weak var reviewOfSymptomsButton: UIButton!
    
    @IBOutlet weak var assessmentQuizButton: UIButton!
    
    @IBOutlet weak var clearNoteButton: UIButton!
    @IBOutlet weak var makeNoteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad();
        reviewOfSymptomsButton.addTarget(self, action: #selector(reviewOfSymptomsButtonClicked(sender:)), for: .touchUpInside)
        assessmentQuizButton.addTarget(self, action: #selector(assessmentQuizButtonClicked(sender:)), for: .touchUpInside)
        
        makeNoteButton.addTarget(self, action: #selector(makeNoteButtonClicked(sender:)), for: .touchUpInside)
        
        clearNoteButton.addTarget(self, action: #selector(clearNoteButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        
        reviewOfSymptomsButton.layer.borderWidth = 1;
        reviewOfSymptomsButton.layer.borderColor = reviewOfSymptomsButton.tintColor.cgColor
        
        assessmentQuizButton.layer.borderWidth = 1;
        assessmentQuizButton.layer.borderColor = assessmentQuizButton.tintColor.cgColor;

        
    }
    
    func assessmentQuizButtonClicked(sender: UIButton){
        let rootItem = DataStore.get().rootItemAssessmentQuiz;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AssessmentController") as! AssessmentController
        controller.setItem(rootItem: rootItem.nextItems[0]);
        self.navigationController?.pushViewController(controller, animated: true);
    }
    
    func reviewOfSymptomsButtonClicked(sender:UIButton){
        let rootItem = DataStore.get().rootItemExamination;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemTableController") as! ItemTableController
        print(rootItem.nextItems[0]);
        controller.setItem(item: rootItem.nextItems[0]);
        self.navigationController?.pushViewController(controller, animated: true);
    }
    
    func makeNoteButtonClicked(sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NoteEditController") as! NoteEditController
        let note = Note(title: "", text: (DataStore.get().rootItemExamination.toString()), exam_root: DataStore.get().rootItemExamination, assessment_root: DataStore.get().rootItemAssessmentQuiz);
        controller.setNote(note: note, isEditingExisting: false);
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func clearNoteButtonClicked(sender: UIButton){
        
        let alertController = UIAlertController(title: "Clear Note", message: "Are you sure you want to clear this note?", preferredStyle: UIAlertControllerStyle.alert)
        let clearAction = UIAlertAction(title: "Clear", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
            DataStore.get().rootItemExamination.switchOffAllItems();
            DataStore.get().rootItemAssessmentQuiz.switchOffAllItems();

        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(clearAction)
        alertController.addAction(cancelAction)
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
        
        
    }

}
