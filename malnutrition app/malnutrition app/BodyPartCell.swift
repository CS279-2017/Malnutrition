//
//  BodyPartCell.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class BodyPartCell:UITableViewCell{
    var item:Item?
    var titleLabel = UILabel();
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.backgroundColor = UIColor.yellow
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.contentView.addSubview(titleLabel)
        
        titleLabel.sizeToFit();
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true;
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true;
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true;
        titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true;

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
