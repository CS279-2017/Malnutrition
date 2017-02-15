//
//  BaseController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 2/6/17.
//  Copyright © 2017 Bowen Jin. All rights reserved.
//

import UIKit

class BaseController: GAITrackedViewController{
    
//    override func viewDidLoad() {
//        ();
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        authenticate();
        hideKeyboardWhenTappedAround();
    }
    
    func showProgressBar(msg:String, _ indicator:Bool, width: CGFloat) {
        if(self.view.viewWithTag(200) != nil){
            self.view.viewWithTag(200)?.isHidden = false;
        }
        else{
            var messageFrame = UIView()
            var activityIndicator = UIActivityIndicatorView()
            var strLabel = UILabel()
            strLabel.layer.zPosition = 9;
            messageFrame.layer.zPosition = 9;
            activityIndicator.layer.zPosition = 9;
            
            
            strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
            strLabel.text = msg
            strLabel.textColor = UIColor.white
            messageFrame = UIView(frame: CGRect(x: view.frame.midX - width/2, y: view.frame.midY - 25 , width: width, height: 50))
            messageFrame.layer.cornerRadius = 15
            messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
            if indicator {
                activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
                activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                activityIndicator.startAnimating()
                messageFrame.addSubview(activityIndicator)
            }
            messageFrame.addSubview(strLabel)
            messageFrame.tag = 200;
            self.view.addSubview(messageFrame)
        }
    }
    
    func hideProgressBar(){
        if(self.view.viewWithTag(200) != nil){
            self.view.viewWithTag(200)?.isHidden = true;
        }
    }
    
    func authenticate(){
        if(!isLoginController()){
            var authKey = ""
            if let key = UserData.get()?.authKey{
                authKey = key;
            }
            var userId = "";
            if let id = UserData.get()?.userId{
                userId = id;
            }
            DataStore.get().authenticate(authKey: authKey, userId: userId, callback:{
                
            }, error_handler: {error in
                if(!(self is LoginController)){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "FirstController") as! FirstController
                    self.present(controller, animated: true, completion: nil);
                }
                //            DataStore.get().error_handler(error: error);
            })
        }
    }
    
    func isLoginController() -> Bool{
        return (self is LoginController) || (self is RegisterController) || (self is FirstController)
    }
    
    func popToRootViewController(animated: Bool){
        DispatchQueue.main.async {
            self.view.window!.rootViewController?.dismiss(animated: animated, completion: nil)
        }
    }
}
