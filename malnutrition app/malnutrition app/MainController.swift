//
//  ViewController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/1/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet weak var viewNotesButton: UIButton!
    @IBOutlet weak var examinationButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        examinationButton.addTarget(self, action: #selector(startButtonClicked) , for: UIControlEvents.touchUpInside)
        viewNotesButton.addTarget(self, action: #selector(viewNotesButtonClicked(button:)), for: UIControlEvents.touchUpInside);
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewNotesButtonClicked(button:UIButton){
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


}
