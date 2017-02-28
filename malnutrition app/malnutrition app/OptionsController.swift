//
//  OptionsController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 2/26/17.
//  Copyright © 2017 Bowen Jin. All rights reserved.
//

import UIKit

class OptionsController:UITableViewController{
    var identifier: String?
    var cellTextArray = [String]();
    var parentController: SurveyController?;
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let identifier = self.identifier else{
            DataStore.get().errorHandler(error: "No identifier set");
            return;
        }
        if identifier == "vumcUnit"{
            cellTextArray = DataStore.get().vumcUnitOptions;
        }
        else if identifier == "clinicianType"{
            cellTextArray = DataStore.get().clinicianTypeOptions;
        }
        tableView.reloadData();
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTextArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let text = cellTextArray[indexPath.row];
        cell.textLabel?.text = text
        if(identifier == "vumcUnit"){
            if(parentController?.vumcUnit == text){
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
            }
        }
        else if(identifier == "clinicianType"){
            if(parentController?.clinicianType == text){
               tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
            }
        }
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath);
        if(identifier == "vumcUnit"){
            let text = cell?.textLabel?.text
            parentController?.vumcUnit = text
//            parentController?.vumcUnitLabel.text = text;
        }
        else if(identifier == "clinicianType"){
            let text = cell?.textLabel?.text
            parentController?.clinicianType = text
//            parentController?.clinicianTypeLabel.text = text
        }
        cell?.accessoryType = .checkmark;
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath);
        cell?.accessoryType = .none;
    }
}
