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
        var newViewController = UIViewController();
        var tableView = UITableView();
        var tableCell = UITableViewCell();
        newViewController.view = tableView;
        self.navigationController?.pushViewController(newViewController, animated: true);
        
    }


}

