//
//  NoteEditController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class NoteEditController:UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    var edittingExistingNote: Bool?
    var note: Note?;
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround();
        if(note != nil){
            let noteText = note!.text;
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
        
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        
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
                if(DataStore.get().noteBook.get(title: enteredTitle) != nil){
                    DataStore.get().error_handler(error: "There's already a note with this title, please use a unique title!");
                }
                else{
                    let noteBook = DataStore.get().noteBook
                    noteBook.addNote(note: note!);
                    if(DataStore.get().save() != true){
                        print("unable to save note");
                    }
                    else{
                        print("save note successful!")
                        self.performSegue(withIdentifier: "unwindFromNoteEditController", sender: self);
                        DataStore.get().rootItemExamination.switchOffAllItems();


                    }
                }
            }
        }
        else{
            if(enteredTitle == ""){
                DataStore.get().error_handler(error: "You must enter a title");
            }
            else{
                if(enteredTitle != note!.title && DataStore.get().noteBook.get(title: enteredTitle) != nil){
                    DataStore.get().error_handler(error: "There's already a note with this title, please use a unique title!");
                }
                else{
                    note!.title = titleTextField.text!
                    note!.text = textView.text!
                    print("save note successful!")
                    self.navigationController?.popViewController(animated: true);
//                    self.performSegue(withIdentifier: "unwindFromNoteEditController", sender: self);
//                    DataStore.get().rootItem.switchOffAllItems();
                    //note: we don't switch off because we are editing an existing note and not making a new note
                }
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
