//
//  PictureViewController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 12/2/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class PictureViewController: GAITrackedViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate{
    
    var image: UIImage?
    
    @IBOutlet weak var scrollView: UIScrollView!
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
        
        self.screenName = "Picture View Screen";
        
        scrollView.delegate = self;
        
        self.view.backgroundColor = UIColor.black;
        
        self.scrollView.minimumZoomScale = 1.0;
        self.scrollView.maximumZoomScale = 5.0;
        self.scrollView.contentSize = self.imageView.frame.size;
        
        
        
//        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true);
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let tracker = GAI.sharedInstance().defaultTracker
//        tracker?.set(kGAIDescription, value: "Picture View Screen")
//        let eventTracker: NSObject = GAIDictionaryBuilder.createScreenView().build()
//        tracker?.send(eventTracker as! [NSObject : AnyObject])
    }
    
    func viewTapped(sender:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil);
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
