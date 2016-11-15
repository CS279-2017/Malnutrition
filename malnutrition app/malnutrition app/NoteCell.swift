//
//  NoteCell.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation
import UIKit

class NoteCell: UITableViewCell{
    var note: Note?
    var titleLabel = UILabel();
    var textBodyLabel = UILabel();
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        textBodyLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(textBodyLabel);
        
        titleLabel.sizeToFit();
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true;
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true;
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true;
        
        textBodyLabel.sizeToFit();
        textBodyLabel.numberOfLines = 0;
        textBodyLabel.lineBreakMode = .byWordWrapping
        //        NSLayoutConstraint(item: textBodyLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        textBodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true;
        textBodyLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true;
        textBodyLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true;
        textBodyLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNote(note: Note){
        self.note = note;
        self.titleLabel.text = note.title;
        self.textBodyLabel.text = note.text;
    }
}
