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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    
//        titleLabel.backgroundColor = UIColor.yellow
//        descriptionLabel.backgroundColor = UIColor.blue
//        titleLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
//        descriptionLabel.frame = CGRect(x: 20, y: 35, width: 100, height: 30);
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel);
        
        titleLabel.sizeToFit();
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true;
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true;
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true;
        
        descriptionLabel.sizeToFit();
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.lineBreakMode = .byWordWrapping
//        NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true;
        descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true;
        descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true;
        descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true;
        
//        descriptionLabelTopConstraint.isActive = true;
//        descriptionLabelLeadingConstraint.isActive = true;
//        descriptionLabelTrailingConstraint.isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}

//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//    }
