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
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
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
        self.bodyLabel.text = note.text;
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        self.dateTimeLabel.text = "Created On: " + dateFormatter.string(from: note.dateCreated)
        
        deleteButton.adjustsImageWhenHighlighted = false;
        editButton.adjustsImageWhenHighlighted = false;
        
        deleteButton.addTarget(self, action: #selector(startFade(button:)), for: .touchDown)
        deleteButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpOutside)
        
        editButton.addTarget(self, action: #selector(startFade(button:)), for: .touchDown)
        editButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpOutside)

    }
    
    
    
    func startFade(button: UIButton){
//        UIView.animate(withDuration: 0.2, animations: { button.alpha = 0.25})
        button.alpha = 0.25
    }
    
    func stopFade(button: UIButton){
//        button.alpha = 1.0
        UIView.animate(withDuration: 0.25, animations: { button.alpha = 1.0})
    }
}
