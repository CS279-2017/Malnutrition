//
//  TextFieldCell.swift
//  malnutrition app
//
//  Created by Bowen Jin on 12/1/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell, UITextFieldDelegate{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    func setTitle(title: String){
        self.label.text = title;
        self.textField.placeholder = "Enter " + title;
        textField.returnKeyType = .done;
    }
    
}
