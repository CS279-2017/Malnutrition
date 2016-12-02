//
//  ItemTableCell.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/28/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit

class ItemTableCell:UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var item:Item?;
    
    let defaultTintColor = UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1)
    let defaultSeparatorColor = UIColor(colorLiteralRed: 200/255, green: 199/255, blue: 204/255, alpha: 1.0)
    
    @IBOutlet weak var optionsStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var optionsStackViewHolder: UIStackView?;
    var collectionViewHolder: UICollectionView?;

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setItem(item: Item){
        if(collectionView == nil){
            collectionView = collectionViewHolder;
        }
        if(optionsStackView == nil){
            optionsStackView = optionsStackViewHolder
        }
        self.item = item;
        print(self.item);
        if(titleLabel != nil){
            titleLabel.text = item.title
        }
        if(collectionView != nil){
            self.collectionView.delegate = self;
            self.collectionView.dataSource = self;
        }
        if(item.description != nil && item.description != "null"){
            if(descriptionLabel != nil){
                descriptionLabel.text = item.description
            }
        }
        else{
            if(descriptionLabel != nil){
                descriptionLabel.text = "";
            }
        }
        if(item.images.count == 0){
            if(collectionView != nil){
                collectionViewHolder = collectionView;
                collectionView.removeFromSuperview();
            }
        }
        if(item.options.count == 0){
            if(optionsStackView != nil){
                optionsStackViewHolder = optionsStackView;
                optionsStackView.removeFromSuperview();
            }
        }
        
        //TODO: add some code to get the images from the urls
        
        var i = 0;
        for subview in optionsStackView.subviews{
            if(i < item.options.count){
                let button = subview as! UIButton;
                button.titleLabel?.minimumScaleFactor = 0.25;
                button.titleLabel?.numberOfLines = 2;
                button.titleLabel?.adjustsFontSizeToFitWidth = true;
                button.setTitle(item.options[i], for: .normal)
                subview.isHidden = false;
                if(item.optionsSelectedIndex == i){
                    button.tintColor = defaultTintColor;
                }
                else{
                    button.tintColor = defaultSeparatorColor;
                }
                button.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
                
            }
            else{
                subview.isHidden = true;
            }
            i += 1;
        };
        collectionView.reloadData();
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionCell;
        let imageView = cell.imageView
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(imageTapped(gestureRecognizer:)))
        imageView?.isUserInteractionEnabled = true
        imageView?.addGestureRecognizer(tapGestureRecognizer)
   
        cell.updateImageUrlString(url: (self.item?.images[indexPath.row])!);
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (item?.images.count)!
    }
    
    func buttonClicked(button: UIButton){
        for view in optionsStackView.subviews{
            let button = view as! UIButton
            button.tintColor = defaultSeparatorColor
        }
        button.tintColor = defaultTintColor
        item?.switched = true;
        var i = 0;
        for view in (button.superview?.subviews)!{
            if(button == view){
                item?.optionsSelectedIndex = i;
            }
            i += 1;
        }

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
