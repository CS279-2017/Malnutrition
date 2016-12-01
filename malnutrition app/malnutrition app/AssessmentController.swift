//
//  AssessmentController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 12/1/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class AssessmentController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var assessmentRootItem: Item?
    
    var assessmentItemsArray: [Item]?
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround();

        super.viewDidLoad()
        tableView.dataSource = self;
        tableView.delegate = self;
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50;
        
        tableView.allowsSelection = false;
        self.automaticallyAdjustsScrollViewInsets = false

        tableView.tableFooterView = UIView();
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if assessmentItemsArray != nil{
            if let item = assessmentItemsArray?[indexPath.row]{
                if(item.type == "textbox"){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell;
                    cell.setItem(item: item);
                    return cell;
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableCell") as! ItemTableCell;
                    cell.setItem(item: item)
                    return cell;
                }
            }
        }
        return UITableViewCell();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = assessmentItemsArray{
            return array.count;
        }
        return 0;
    }
    
    func setItem(rootItem: Item){
        self.assessmentRootItem = rootItem;
        self.assessmentItemsArray = rootItem.nextItems;
        
    }
    
}
