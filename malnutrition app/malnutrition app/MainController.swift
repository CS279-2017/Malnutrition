//
//  ViewController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/1/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//


import UIKit
import Firebase

class MainController: BaseController {

    @IBOutlet weak var viewNotesButton: BaseButton!
    @IBOutlet weak var examinationButton: BaseButton!

    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var referencesButton: BaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        examinationButton.addTarget(self, action: #selector(startButtonClicked) , for: UIControlEvents.touchUpInside)
        viewNotesButton.addTarget(self, action: #selector(viewNotesButtonClicked(button:)), for: UIControlEvents.touchUpInside);
        
//        viewNotesButton.layer.borderWidth = 1;
//        viewNotesButton.layer.borderColor = viewNotesButton.tintColor.cgColor;
//        
//        examinationButton.layer.borderWidth = 1;
//        examinationButton.layer.borderColor = viewNotesButton.tintColor.cgColor;
//        referencesButton.layer.borderWidth = 1;
//        referencesButton.layer.borderColor = referencesButton.tintColor.cgColor
        
        examinationButton.addTarget(self, action: #selector(startFade(button:)), for: .touchDown)
        examinationButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpInside)
        examinationButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpOutside)
        
        viewNotesButton.addTarget(self, action: #selector(startFade(button:)), for: .touchDown)
        viewNotesButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpInside)
        viewNotesButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpOutside)
        
        referencesButton.addTarget(self, action: #selector(startFade(button:)), for: .touchDown)
        referencesButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpInside)
        referencesButton.addTarget(self, action: #selector(stopFade(button:)), for: .touchUpOutside)
        
        self.screenName = "Main Screen";        
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        logoutButton.target = self;
        logoutButton.action = #selector(logoutButtonClicked);
//        FIRAnalytics.logEvent(withName: "Main Screen", parameters: [:])
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewNotesButtonClicked(button:BaseButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NoteController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func unwindToMainController(segue: UIStoryboardSegue) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "NoteController")
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func logoutButtonClicked(){
        let alertController = UIAlertController(title: NSLocalizedString("Logout", comment: ""), message: NSLocalizedString("Are You Sure You Want To Logout?", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
        let logoutAction = UIAlertAction(title: NSLocalizedString("Logout", comment: ""), style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            self.showProgressBar(msg: "Logging Out", true, width: 150);
            DataStore.get().logout(callback: {
                self.hideProgressBar();
                (UIApplication.shared.delegate as! AppDelegate).popToFirstController();
            }, errorHandler: {error in
                self.hideProgressBar();
                DataStore.get().errorHandler(error: error);
            });
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            
        }
        alertController.addAction(logoutAction);
        alertController.addAction(cancelAction);
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }


}
