//
//  LoginController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 2/6/17.
//  Copyright © 2017 Bowen Jin. All rights reserved.
//

import UIKit


class LoginController: BaseController, UITextFieldDelegate{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        emailTextField.returnKeyType = .next
        emailTextField.delegate = self;
        emailTextField.placeholder = "Enter Email";
        passwordTextField.isSecureTextEntry = true;
        passwordTextField.delegate = self;
        passwordTextField.returnKeyType = .done
        passwordTextField.placeholder = "Enter Password";
        loginButton.setTitle("Login", for: .normal);
        
        self.screenName = "Login Screen";
    }
    
    
    func loginButtonClicked(){
        guard let email = emailTextField.text else {DataStore.get().error_handler(error: "Enter Email"); return;}
        guard let password = passwordTextField.text else {DataStore.get().error_handler(error: "Enter Password"); return;}
//        self.showProgressBar(msg: "Logging In", true, width: 150);
        if(email == ""){
           DataStore.get().error_handler(error: "Enter Email"); return;
        }
        if(password == ""){
            DataStore.get().error_handler(error: "Enter Password"); return;
        }
        DataStore.get().login(email: email, password: password, callback: { authKey in 
            self.hideProgressBar();
            self.popToRootViewController(animated: true);
        }, error_handler: {error in
            DataStore.get().error_handler(error: error);
            self.hideProgressBar();
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == emailTextField){
            emailTextField.resignFirstResponder();
            passwordTextField.becomeFirstResponder();
        }
        if(textField == passwordTextField){
            loginButtonClicked();
        }
        return false;
    }
}
