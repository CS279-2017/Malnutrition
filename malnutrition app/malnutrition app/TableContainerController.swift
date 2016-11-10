//
//  TableContainerController.swift
//  YanDingiOSApp
//
//  Created by Bowen Jin on 9/24/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import UIKit
class TableContainerController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataStore: DataStore = DataStore.get();
    
//    var wordList:[Word]? = [Word]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        //TODO: add label to footer to show "没有单词“
        tableView.tableFooterView = UIView();
        
    }
    
//    func setNewWordList(wordList: [Word]){
//        self.wordList = wordList;
//        tableView.reloadData();
//        if(self.wordList!.count == 0)
//        {
//            tableView.hidden = true;
//        }
//        else{
//            tableView.hidden = false;
//        }
//    }
    
    //****TABLEVIEW METHODS*****//
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "WordTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WordTableCell
        var word: Word?;
        word = wordList![indexPath.row]
        cell.setCellWord(word!);
        if((parentViewController?.isKindOfClass(FavoritesViewController)) == true){
            cell.favoritesButton.hidden = true;
        }

//        cell.word = word; 
//        cell.wordNameLabel.text = word!.wordName
//        cell.definitionLabel.text = word!.definition
//        if(word!.partOfSpeech != nil){
//            cell.partOfSpeechLabel.text = word!.partOfSpeech
//        }
//        if(word!.pronunciation != nil){
//            cell.partOfSpeechLabel.text = cell.partOfSpeechLabel.text!.stringByAppendingString("[" + word!.pronunciation! + "]")
//        }
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(wordList != nil){
           return wordList!.count;
        }
        return 0;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
//        let favorite = UITableViewRowAction(style: .Normal, title: "收藏") { action, index in
//            print("favorite button tapped")
//        }
//        favorite.backgroundColor = UIColor.lightGrayColor();
        if((parentViewController?.isKindOfClass(FavoritesViewController)) == true){
            let delete = UITableViewRowAction(style: .Normal, title: "删除") { action, index in
                DataStore.get().deleteWordFromFavorites(indexPath.row)
                self.wordList!.removeAtIndex(indexPath.row)
                self.tableView.reloadData()
            }
            delete.backgroundColor = UIColor.redColor();
            
            return [delete]
        }
        else if(parentViewController?.isKindOfClass(SearchViewController) == true){
            return [];
        }
        else{
            let delete = UITableViewRowAction(style: .Normal, title: "隐藏") { action, index in
                self.wordList!.removeAtIndex(indexPath.row)
                self.tableView.reloadData();
            }
            delete.backgroundColor = UIColor.lightGrayColor()
            
            return [delete]
        }
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            wordList!.removeAtIndex(indexPath.row);
            tableView.reloadData();
        }
    }
    
}
