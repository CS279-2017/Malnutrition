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
    
    //stores one level of items (previous levels are inaccessible)
    var items: [Item] = [Item]();
    
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
    
    func setItems(items: [Item]){
        self.items = items;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableViewCell = TableViewCell();
        tableViewCell.setItem(item: items[indexPath.row]);
        return tableViewCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        
        let item = items[row];
        let nextItems = item.nextItems;
        let newViewController = TableViewController();
        newViewController.setItems(items: nextItems);
        navigationController?.pushViewController(newViewController, animated: true);
        
        
    }
    
}
