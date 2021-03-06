//
//  ItemTableController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/6/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation
import UIKit

class ItemTableController: BaseController, UITableViewDelegate, UITableViewDataSource{
    
    //this is the item which the view controller represents
    var item:Item?;
    
    @IBOutlet weak var tableView: UITableView!
    //creates and initializes the tableView, setting the delegate and data source of the tableView to this class.
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.hideKeyboardWhenTappedAround();

        
        self.automaticallyAdjustsScrollViewInsets = false

//        if(item.title = "Root"){
//            
//        }
//        let makeNoteButton = UIBarButtonItem(title: "Make Note", style: .plain, target: self, action: #selector(makeNoteButtonClicked(sender:)))
//        self.navigationItem.rightBarButtonItem = makeNoteButton
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100;
        tableView.tableFooterView = UIView();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(item?.type == "Body Region"){
            self.screenName = "Body Region Screen"
        }
        else if(item?.type == "Body Diagram"){
            self.screenName = "Body Diagram Screen"
        }
        else{
            self.screenName = "Other Item Screen"
        }
    }
    
    func setItem(item: Item){
        self.item = item;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(item != nil){
            return item!.nextItems.count;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if(item != nil && row < (item?.nextItems.count)!){
            let item = self.item?.nextItems[row];
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableCell", for: indexPath) as! ItemTableCell;
            if(item != nil){
                cell.setItem(item: item!);
            }
            return cell;
        }
        return UITableViewCell();
    }
    
    
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let row = indexPath.row
        let item = self.item?.nextItems[row];
        if(item?.nextItems.count != 0){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ItemTableController") as! ItemTableController
            controller.setItem(item: item!);
            self.navigationController?.pushViewController(controller, animated: true);
        }
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
