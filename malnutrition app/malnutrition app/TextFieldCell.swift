//
//  TextFieldCell.swift
//  malnutrition app
//
//  Created by Bowen Jin on 12/1/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell, UITextFieldDelegate{
    
    var item: Item?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.selectionStyle = .none

    }
    
    func setItem(item: Item){
        self.item = item;
        self.label.text = item.title;
        self.textField.delegate = self;
        if(item.value == nil){
            self.textField.placeholder = "Enter " + item.title!;
        }
        else{
            self.textField.text = item.value;

        }
        textField.returnKeyType = .done;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(item != nil){
            self.item?.value = textField.text
            item?.switched = true;
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true);
        return false;
    }
    
}
