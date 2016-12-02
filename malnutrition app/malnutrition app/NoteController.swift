//
//  NoteController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation
import UIKit
class NoteController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var noteBook = DataStore.get().noteBook;
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
        
        displayedNotes = DataStore.get().noteBook.getAllNotes();
        
        searchBar.delegate = self;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData();
    }
    
    //build a full search function later on that searches for prefixes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        displayedNotes = noteBook.getNotesWithPrefix(prefix: searchText);
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
    
    func deleteNoteButtonClicked(button: UIButton){
        let note = displayedNotes[button.tag];
        noteBook.deleteNote(note: note);
        updateDisplayedNotes();
        tableView.deleteRows(at: [IndexPath(row: button.tag, section: 0)]
, with: UITableViewRowAnimation.automatic)
//        if(DataStore.get().save() != true){
//            print("unable to save note");
//        }
//        else{
//            print("save note successful!")
//        }
//        tableView.reloadData();
    }
    
    func editNoteButtonClicked(button: UIButton){
//        let note = displayedNotes[indexPath.row];
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "NoteEditController") as! NoteEditController
//        controller.setNote(note: note, isEditingExisting: true);
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    
    func updateDisplayedNotes(){
        if(searchQuery == nil){
            displayedNotes = DataStore.get().noteBook.getAllNotes();
        }
        else{
            displayedNotes = DataStore.get().noteBook.getNotesWithPrefix(prefix: searchQuery!);
        }
        
    }
}
