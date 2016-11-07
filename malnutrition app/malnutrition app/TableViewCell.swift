//
//  TableViewCell.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/6/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation
import UIKit

//TableViewCell is just a class that is used to create an instance of UITableViewCell, which is then returned to the delegate cellForRowAtIndexPath in TableViewController, after some modifications such as setting the item
class TableViewCell: UITableViewCell{
    var item: Item?;
    var label:UILabel = UILabel();
    
    init(item: Item) {
        print("init called");
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        self.item = item;
        self.label.text = item.text;
        addSubview(label);
        print(self.label.text);
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
