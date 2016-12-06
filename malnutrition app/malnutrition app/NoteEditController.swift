//
//  NoteEditController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class NoteEditController:GAITrackedViewController, UITextFieldDelegate, UITextViewDelegate{
    
    var edittingExistingNote: Bool?
    var note: Note?;
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround();
        if(note != nil){
            let noteText = note!.textContent;
            let noteTitle = note!.title;
            if(noteTitle == ""){
                titleTextField.placeholder = "Enter Title of Note"
            }
            else{
                self.titleTextField.text = noteTitle;
            }
            textView.text! = noteText;
        }
        titleTextField.delegate = self;
        textView.delegate = self;
        
        titleTextField.returnKeyType = .done;
//        self.view.addSubview(textView)
//        self.view.addSubview(titleTextField)\
        
        textView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5;
        
        self.screenName = "Note Edit Screen"
        
//        textView.layer.cornerRadius =
        
        let saveNoteButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveNoteButtonClicked(button:)))
        self.navigationItem.rightBarButtonItem = saveNoteButton;
//        self.navigationItem.rightBarButtonItem = saveNoteButton
    }
    
    func saveNoteButtonClicked(button: UIBarButtonItem){
        //TODO: Validate that title isn't empty
        let enteredTitle = titleTextField.text!;
        if(self.edittingExistingNote == false){
            if(enteredTitle == ""){
                DataStore.get().error_handler(error: "You must enter a title");
            }
            else{
                note!.title = titleTextField.text!
                note?.textContent = textView.text!
                DataStore.get().addNote(note: note!, callback: {self.performSegue(withIdentifier: "unwindFromNoteEditController", sender: self);
                DataStore.get().clearNote();}, error_handler: DataStore.get().error_handler)
            }
        }
        else{
            if(enteredTitle == ""){
                DataStore.get().error_handler(error: "You must enter a title");
            }
            else{
                note!.title = titleTextField.text!
                note!.textContent = textView.text!
                note!.dateLastEdited = Date();
                if(DataStore.get().save()){
                    self.navigationController?.popViewController(animated: true);
                }
                else{
                    DataStore.get().error_handler(error: "Unable to save note");
                }
    //                    self.performSegue(withIdentifier: "unwindFromNoteEditController", sender: self);
    //                    DataStore.get().rootItem.switchOffAllItems();
                //note: we don't switch off because we are editing an existing note and not making a new note
            }
        }
    }
    
    func setNote(note: Note, isEditingExisting: Bool){
        self.note = note;
        self.edittingExistingNote = isEditingExisting;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true);
        return false;
    }
    
}
