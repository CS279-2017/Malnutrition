//
//  NoteController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

//<Google/Analytics.h>

import Foundation
import UIKit
class NoteController: BaseController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var noteBook = UserData.get()?.noteBook;
    var displayedNotes:[Note] = [];
    
    var searchQuery: String?
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround();

//        tableView.register(NoteCell.self, forCellReuseIdentifier: "NoteCell")
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.tableFooterView = UIView();
        
        tableView.allowsSelection = false;
        
        if let allNotes = UserData.get()?.noteBook?.getAllNotes(){
            displayedNotes = allNotes;
        };
        
        searchBar.delegate = self;
        
        self.screenName = "Note View Screen";
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData();
        
        let tracker = GAI.sharedInstance().defaultTracker
        tracker?.set(kGAIDescription, value: "Note View Screen")
        let eventTracker: NSObject = GAIDictionaryBuilder.createScreenView().build()
        tracker?.send(eventTracker as! [NSObject : AnyObject])
    }
    
    //build a full search function later on that searches for prefixes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let notes = noteBook?.getNotesWithPrefix(prefix: searchText){
            displayedNotes = notes;
        }
        searchQuery = searchText;
        tableView.reloadData();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedNotes.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = displayedNotes[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.setNote(note: note);
        cell.editButton.tag = indexPath.row;
        cell.deleteButton.tag = indexPath.row
        
        cell.editButton.addTarget(self, action: #selector(editNoteButtonClicked(button:)), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(deleteNoteButtonClicked(button:)), for: .touchUpInside)

        return cell;
        
    }
    
    func deleteNoteButtonClicked(button: BaseButton){
        let alertController = UIAlertController(title: "Delete Note", message: "Are you sure you want to delete this note?", preferredStyle: UIAlertControllerStyle.alert)
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
            let note = self.displayedNotes[button.tag];
            UserData.deleteNote(note: note, callback: {
                self.updateDisplayedNotes();
                self.tableView.deleteRows(at: [IndexPath(row: button.tag, section: 0)]
                    , with: UITableViewRowAnimation.automatic)
            }, errorHandler: DataStore.get().errorHandler);
        
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
       
        
    }
    
    func editNoteButtonClicked(button: BaseButton){
        let note = displayedNotes[button.tag];
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NoteEditController") as! NoteEditController
        controller.setNote(note: note, isEditingExisting: true);
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    
    func updateDisplayedNotes(){
        if(searchQuery == nil){
            if let allNotes = UserData.get()?.noteBook?.getAllNotes(){
                displayedNotes = allNotes;
            };
        }
        else{
            if let notes = UserData.get()?.noteBook?.getNotesWithPrefix(prefix: searchQuery!){
                displayedNotes = notes;
            }
        }
        
    }
}
