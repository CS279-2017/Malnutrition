//
//  ItemTableController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/6/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation
import UIKit

class ItemTableController: UIViewController, UITableViewDelegate, UITableViewDataSource, ItemController{
    
    //this is the item which the view controller represents
    var item:Item?;
    var tableView = UITableView();
    
    //creates and initializes the tableView, setting the delegate and data source of the tableView to this class.
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SymptomCell.self, forCellReuseIdentifier: "SymptomCell")
        tableView.register(BodyPartCell.self, forCellReuseIdentifier: "BodyPartCell")
        tableView.register(MakeNoteCell.self, forCellReuseIdentifier: "MakeNoteCell")
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.view = self.tableView;
        print(item?.title);
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
//        let camera = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: Selector(("btnOpenCamera")))
        let makeNoteButton = UIBarButtonItem(title: "Make Note", style: .plain, target: self, action: #selector(makeNoteButtonClicked(sender:)))

        self.navigationItem.rightBarButtonItem = makeNoteButton
        
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 140
        
        //TODO: add label to footer to show "没有单词“
        tableView.tableFooterView = UIView();
        
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300;
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension;
//    }

    func setItem(item: Item){
        self.item = item;
        self.tableView.reloadData();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item!.nextItems.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = self.item?.nextItems[row];
        if(item?.type != nil && item?.type! == "Body Diagram"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "BodyPartCell", for: indexPath) as! BodyPartCell
            cell.item = item;
            cell.titleLabel.text = item!.title;
            return cell;
        }
        else if(item?.type != nil && item?.type! == "Make Note"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MakeNoteCell", for: indexPath) as! MakeNoteCell
//            cell.item = item;
            return cell;
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomCell", for: indexPath) as! SymptomCell
            cell.item = item;
            cell.titleLabel.text = item!.title
            cell.descriptionLabel.text = item!.description
            if(item?.nextItems.count == 0){
                //            cell.textLabel?.text = item?.title;
                let switchView = UISwitch();
                switchView.addTarget(self, action: #selector(switchClicked(sender:)), for: UIControlEvents.touchUpInside);
                switchView.isOn = (item?.switched)!;
                cell.accessoryView = switchView;
                
            }
            else{
                //            cell.textLabel?.text = item?.title;
            }
            return cell;
        }
    }
    
    
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        let item = self.item?.nextItems[row];
        if(item?.nextItems.count != 0){
            let newViewController = ItemTableController();
            newViewController.setItem(item: item!);
            navigationController?.pushViewController(newViewController, animated: true);
        }
    }
    
    func switchClicked(sender: UISwitch){
        let cell = sender.superview as! SymptomCell;
        cell.item!.toggleSwitch();
    }
    
    func makeNoteButtonClicked(sender: UIBarButtonItem){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NoteEditController") as! NoteEditController
        controller.textBody = (self.item?.toString())!;
        self.navigationController?.pushViewController(controller, animated: true)
    }
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        print("tableViewCell was clicked");
//        
////        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
//        
//        let row = indexPath.row
//        let item = self.item.nextItems[row];
//        let newViewController = ItemTableController();
//        newViewController.setItem(item: item);
//        navigationController?.pushViewController(newViewController, animated: true);
//    }

    
}
