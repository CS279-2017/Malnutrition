//
//  SymptomCell.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/13/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit
class SymptomCell: UITableViewCell {
    
    var item:Item?
    var titleLabel = UILabel();
    var descriptionLabel = UILabel();
    var selectedSwitch = UISwitch();
    var switched = false;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.backgroundColor = UIColor.yellow
        descriptionLabel.backgroundColor = UIColor.blue
        titleLabel.frame = CGRect(x: 20, y: 0, width: 100, height: 30)
        descriptionLabel.frame = CGRect(x: 20, y: 35, width: 100, height: 30);
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}

//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//    }
