//
//  ImageCollectionCell.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/28/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class ImageCollectionCell:UICollectionViewCell{
    
    var imageUrlString:String?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateImageUrlString(url: String){
        imageUrlString = url;
        self.downloadedFrom(link: imageUrlString!)
        self.activityIndicator.startAnimating();
    }
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.imageView.image = image
                self.activityIndicator.stopAnimating();
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
