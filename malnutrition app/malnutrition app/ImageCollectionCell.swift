//
//  ImageCollectionCell.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/28/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation
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
        print(url);
//        downloadImage(url: URL(fileURLWithPath: url))
        self.downloadedFrom(link: imageUrlString!)
        self.activityIndicator.startAnimating();
    }
    
//    func downloadImage(url: URL) {
//        print("Download Started")
//        self.getDataFromUrl(url: url) { (data, response, error)  in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//            DispatchQueue.main.async() { () -> Void in
//                self.imageView.image = UIImage(data: data)
//            }
//        }
//    }
    
//    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
//        URLSession.shared.dataTask(with: url) {
//            (data, response, error) in
//            completion(data, response, error)
//            }.resume()
//    }
    
//    func downloadImage(url: URL) {
//        print("Download Started");
//        func downloadImage(url: URL) {
//            print("Download Started")
//            getDataFromUrl(url: url) { (data, response, error)  in
//                guard let data = data, error == nil else { return }
//                print(response?.suggestedFilename ?? url.lastPathComponent)
//                print("Download Finished")
//                DispatchQueue.main.async() { () -> Void in
//                    self.imageView.image = UIImage(data: data)
//                }
//            }
//        }
//    }
    
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
                self.activityIndicator.isHidden = true;
            }
        }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
