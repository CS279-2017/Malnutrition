//
//  RegisterEmailController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 2/10/17.
//  Copyright © 2017 Bowen Jin. All rights reserved.
//

import UIKit


class RegisterController: BaseController{
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: BaseButton!
    @IBOutlet weak var verifyPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        
        passwordTextField.isSecureTextEntry = true;
        verifyPasswordTextField.isSecureTextEntry = true;
        
        self.screenName = "Register Screen";
    }
    
    func registerButtonClicked(){
        //call register
        
        guard let email = emailTextField.text else {DataStore.get().errorHandler(error: "Please enter an email"); return;}
        guard let password = passwordTextField.text else {DataStore.get().errorHandler(error: "Please enter a password"); return;}
        guard let verify_password = verifyPasswordTextField.text else{ DataStore.get().errorHandler(error: "Please enter the password again"); return;}
        if(email == ""){
            DataStore.get().errorHandler(error: "Enter Email"); return;
        }
        if(password == ""){
            DataStore.get().errorHandler(error: "Enter Password"); return;
        }
        if(password != verify_password){
            DataStore.get().errorHandler(error: "Passwords don't match!");
            return;
        }
        DataStore.get().register(email: email, password: password, callback:{
            UserData.set(email: email);
            self.hideProgressBar();
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "RegisterToLogin", sender: nil);
            }
        }, errorHandler:{error in
            print(error);
            DataStore.get().errorHandler(error: error);
        });
    }
}
