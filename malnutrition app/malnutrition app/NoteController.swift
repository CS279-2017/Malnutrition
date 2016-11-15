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
    
    override func viewDidLoad() {
    }
    
    //build a full search function later on that searches for prefixes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        noteBook!.get(title: searchText);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteBook!.size()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell();
    }
}
