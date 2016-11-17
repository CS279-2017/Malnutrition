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
    var allNotes = DataStore.get().noteBook.getAllNotes();
    
    override func viewDidLoad() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: "NoteCell")
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.tableFooterView = UIView();
    }
    
    //build a full search function later on that searches for prefixes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        noteBook.get(title: searchText);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteBook.size()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = allNotes[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.setNote(note: note);
        return cell;
        
    }
}
