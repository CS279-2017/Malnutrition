//
//  BaseButton.swift
//  malnutrition app
//
//  Created by Bowen Jin on 2/27/17.
//  Copyright © 2017 Bowen Jin. All rights reserved.
//
import Firebase
import Foundation

class BaseButton:UIButton{
    override func awakeFromNib() {
//        self.addTarget(self, action: #selector(startFade(button:)), for: .touchDown)
//        self.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpInside)
//        self.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpOutside)
//        self.addTarget(self, action: #selector(stopFade(button:)), for: .touchCancel)
//        
        self.addTarget(self, action: #selector(triggerFireBaseEvent), for: .touchUpInside)
    }
    
    
    func startFade(button: BaseButton){
        //        UIView.animate(withDuration: 0.2, animations: { button.alpha = 0.25})
        button.alpha = 0.25
        button.backgroundColor = UIColor.lightGray;
    }
    
    func stopFade(button: BaseButton){
        //        button.alpha = 1.0
        UIView.animate(withDuration: 0.25, animations: {
            button.alpha = 1.0
            button.backgroundColor = UIColor.lightText;
        })
    }
    
    func triggerFireBaseEvent(){
        if let buttonTitle = self.titleLabel?.text{
            let eventName = (buttonTitle + " clicked").toFireBaseEventName();
            FIRAnalytics.logEvent(withName: eventName, parameters: [:]);
        }
    }
}
