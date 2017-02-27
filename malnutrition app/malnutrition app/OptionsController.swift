//
//  OptionsController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 2/26/17.
//  Copyright © 2017 Bowen Jin. All rights reserved.
//

import UIKit

class OptionsController:UITableViewController{
    var surveyVar: Any?
    var identifier: String?
    var cellTextArray = [String]();
    
    override func viewWillAppear(_ animated: Bool) {
        guard let identifier = self.identifier else{
            DataStore.get().errorHandler(error: "No identifier set");
            return;
        }
        if identifier == "VUMC Unit"{
            cellTextArray = DataStore.get().vumcUnitOptions;
        }
        else if identifier == "Clinician Type"{
            cellTextArray = DataStore.get().clinicianTypeOptions;
        }
        tableView.reloadData();
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTextArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = cellTextArray[indexPath.row];
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath);
        surveyVar = cell?.textLabel?.text!
        cell?.accessoryType = .checkmark;
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath);
        cell?.accessoryType = .none;
    }
}
