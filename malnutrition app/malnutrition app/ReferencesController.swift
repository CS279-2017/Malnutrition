//
//  ReferencesController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 12/4/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class ReferencesController: BaseController{
    
    @IBOutlet weak var diagnosticsImageView: UIImageView!
    
    @IBOutlet weak var icd10ImageView: UIImageView!
    
    override func viewDidLoad() {
        let tap1 = UITapGestureRecognizer(target:self, action: #selector(imageTapped(gestureRecognizer:)))
        let tap2 = UITapGestureRecognizer(target:self, action: #selector(imageTapped(gestureRecognizer:)))
        diagnosticsImageView?.isUserInteractionEnabled = true
        diagnosticsImageView?.addGestureRecognizer(tap1)
        icd10ImageView?.isUserInteractionEnabled = true
        icd10ImageView?.addGestureRecognizer(tap2)
        
        self.screenName = "References Screen";
        
    }
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImageView = gestureRecognizer.view! as! UIImageView
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller : PictureViewController = storyBoard.instantiateViewController(withIdentifier: "PictureViewController") as! PictureViewController
        controller.setImage(image: tappedImageView.image!)
        let topViewController = UIApplication.topViewController();
        topViewController?.present(controller, animated: true, completion: nil)
    }
}
