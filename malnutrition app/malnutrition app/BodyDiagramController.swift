//
//  BodyDiagramView.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation
import UIKit

class BodyDiagramController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var makeNoteButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        makeNoteButton.addTarget(self, action: #selector(makeNoteButtonClicked(button:)), for: .touchUpInside)
        makeNoteButton.titleLabel?.text = "Make Note";
//        makeNoteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        let barButtonItem = UIBarButtonItem();
//        barButtonItem.customView = makeNoteButton;
//        self.navigationController?.navigationBar.addSubview(makeNoteButton as! UIView);
//        self.navigationItem.rightBarButtonItem  = barButtonItem;
//        
    }
    
    func makeNoteButtonClicked(button: UIBarButtonItem){
        print("make note button clicked");
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
}
