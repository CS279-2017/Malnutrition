//
//  NoteEditController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class NoteEditController:UIViewController, UITextViewDelegate{
    var textBody:String = "";
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        titleTextField.placeholder = "Enter Title of Note"
        textView.delegate = self;
        textView.text! = textBody;
//        self.view.addSubview(textView)
//        self.view.addSubview(titleTextField)
        
        let saveNoteButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = saveNoteButton;
//        self.navigationItem.rightBarButtonItem = saveNoteButton
    }
    
    func saveNoteButtonClicked(button: UIBarButtonItem){
        //TODO: Validate that title isn't empty
        let note = Note(title: titleTextField.text!)
        DataStore.get().noteBook?.addNote(note: note);
        if(DataStore.get().save() != true){
            print("unable to save note");
        }
        else{
            print("save note successful!")
        }
    }
    
}
