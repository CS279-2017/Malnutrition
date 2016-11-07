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
        //since we choose to store the entire item directory in one Item object, in a trie like fashion, we must have a rootItem, also since we choose to create the Trie by appending Item objects onto the trie as we read the Json we must have another intial root on which to append to the other nodes, thus we essentially have two 'roots', thus if we want to not display these nodes in the app, we will have to skip the initial root, hence rootItem.nextItems[0]
        newViewController.setItem(item: rootItem.nextItems[0])
        self.navigationController?.pushViewController(newViewController, animated: true);
        //starts the first link in a chain of TableViewControllers each representing one item; 
        
    }


}

