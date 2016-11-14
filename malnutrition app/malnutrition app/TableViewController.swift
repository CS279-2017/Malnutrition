//
//  TableViewController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/6/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //this is the item which the view controller represents
    var item:Item?;
    var tableView = UITableView();
    
    //creates and initializes the tableView, setting the delegate and data source of the tableView to this class.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.view = self.tableView;
        print(item?.title);
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 140
        
        //TODO: add label to footer to show "没有单词“
//        tableView.tableFooterView = UIView();
        
    }
    
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
//        let tableViewCell = TableViewCell(item: item);
//        let cell = UITableViewCell()
//        cell.textLabel = 
//        print(tableViewCell.item?.text)
        let cell = TableViewCell();
        cell.item = item;
        if(item?.nextItems.count == 0){
            cell.textLabel?.text = item?.title;
            let switchView = UISwitch();
            switchView.addTarget(self, action: #selector(switchClicked(sender:)), for: UIControlEvents.touchUpInside);
            switchView.isOn = (item?.switched)!;
            cell.accessoryView = switchView;

        }
        else{
            cell.textLabel?.text = item?.title;
        }
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        let item = self.item?.nextItems[row];
        if(item?.nextItems.count != 0){
            let newViewController = TableViewController();
            newViewController.setItem(item: item!);
            navigationController?.pushViewController(newViewController, animated: true);
        }
    }
    
    func switchClicked(sender: UISwitch){
        let cell = sender.superview as! TableViewCell;
        cell.item!.toggleSwitch();
    }
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        print("tableViewCell was clicked");
//        
////        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
//        
//        let row = indexPath.row
//        let item = self.item.nextItems[row];
//        let newViewController = TableViewController();
//        newViewController.setItem(item: item);
//        navigationController?.pushViewController(newViewController, animated: true);
//    }

    
}
