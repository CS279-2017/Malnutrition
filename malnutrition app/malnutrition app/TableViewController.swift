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
    var item:Item = Item();
    
    //creates and initializes the tableView, setting the delegate and data source of the tableView to this class.
    override func viewDidLoad() {
        super.viewDidLoad()
        var tableView = UITableView();
        self.view = tableView;
        tableView.dataSource = self;
        tableView.delegate = self;
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 140
        
        //TODO: add label to footer to show "没有单词“
//        tableView.tableFooterView = UIView();
        
    }
    
    func setItem(item: Item){
        self.item = item;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.nextItems.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableViewCell = TableViewCell();
        tableViewCell.setItem(item: item.nextItems[indexPath.row]);
        return tableViewCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        let item = self.item.nextItems[row];
        let newViewController = TableViewController();
        newViewController.setItem(item: item);
        navigationController?.pushViewController(newViewController, animated: true);
        
        
    }
    
}
