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
    
    @IBOutlet weak var editButton: BaseButton!
    @IBOutlet weak var deleteButton: BaseButton!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateTimeCreatedLabel: UILabel!
    @IBOutlet weak var dateTimeEditedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
//    var titleLabel = UILabel();
//    var textBodyLabel = UILabel();
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    func setNote(note: Note){
        self.note = note;
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: note.title)
        attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 24), range: NSRange(location: 0, length: attributeString.length))
        self.titleLabel.attributedText = attributeString;
        self.bodyLabel.text = note.textContent;
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        self.dateTimeCreatedLabel.text = "Created On: " + dateFormatter.string(from: note.dateCreated)
        
        //if note has been edited, i.e dateLastEdited != nil, then show last edited text
        if(note.dateLastEdited != nil){
            self.dateTimeEditedLabel.text = "Last Edited: " + dateFormatter.string(from: note.dateLastEdited!)
            self.dateTimeEditedLabel.isHidden = false;
        }
        else{
            self.dateTimeEditedLabel.isHidden = true;
            self.dateTimeEditedLabel.text = nil;
        }
        
        
        deleteButton.adjustsImageWhenHighlighted = false;
        editButton.adjustsImageWhenHighlighted = false;
        
        deleteButton.addTarget(self, action: #selector(startFade(button:)), for: .touchDown)
        deleteButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpOutside)
        
        editButton.addTarget(self, action: #selector(startFade(button:)), for: .touchDown)
        editButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpOutside)

    }
    
    
    
    func startFade(button: BaseButton){
//        UIView.animate(withDuration: 0.2, animations: { button.alpha = 0.25})
        button.alpha = 0.25
    }
    
    func stopFade(button: BaseButton){
//        button.alpha = 1.0
        UIView.animate(withDuration: 0.25, animations: { button.alpha = 1.0})
    }
}
