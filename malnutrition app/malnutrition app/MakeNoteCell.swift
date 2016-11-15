//
//  MakeButtonCell.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation
import UIKit

class MakeNoteCell: UITableViewCell{
    var item:Item?
    var makeNoteButton = UIButton(type: UIButtonType.system);
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeNoteButton.setTitle("Make Note", for: UIControlState.normal);
        makeNoteButton.translatesAutoresizingMaskIntoConstraints = false;
        self.contentView.addSubview(makeNoteButton)
        
//        makeNoteButton.sizeToFit();
//        titleLabel.numberOfLines = 0;
//        titleLabel.lineBreakMode = .byWordWrapping
        makeNoteButton.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true;
        makeNoteButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true;
        makeNoteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true;
        makeNoteButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true;
        
    }
    
    func makeNoteButtonClicked(button: UIButton){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
