//
//  ViewController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/1/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var referenceButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startButton.addTarget(self, action: #selector(startButtonClicked) , for: UIControlEvents.touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startButtonClicked(sender:UIButton){
        let rootItem = DataStore.get().rootItem;
        let newViewController = TableViewController();
        newViewController.setItem(item: rootItem)
        self.navigationController?.pushViewController(newViewController, animated: true);
        //starts the first link in a chain of TableViewControllers each representing one item; 
        
    }


}

