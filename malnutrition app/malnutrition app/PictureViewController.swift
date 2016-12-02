//
//  PictureViewController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 12/2/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var image: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setImage(image: UIImage){
        self.image = image;
        if(imageView != nil){
            imageView.image = image;
        }
    }
    
    override func viewDidLoad() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (viewTapped(sender:)))
        gesture.delegate = self;
        self.imageView.addGestureRecognizer(gesture);
        if(self.image != nil){
            imageView.image = self.image;
        }
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.isUserInteractionEnabled = true;
        imageView.backgroundColor = UIColor.black
    }
    
    func viewTapped(sender:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil);
    }
    
}
