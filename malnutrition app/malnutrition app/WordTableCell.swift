//
//  WordTableCell.swift
//  YanDingiOSApp
//
//  Created by Bowen Jin on 9/16/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation

import AVFoundation

//import Toast_Swift
import UIKit

class WordTableCell: UITableViewCell {
    
    @IBOutlet weak var wordNameLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var playAudioButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    
    var word:Word?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        playAudioButton.addTarget(self, action: #selector(WordTableCell.playSound(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        favoritesButton.addTarget(self, action: #selector(favoriteButtonClicked(_:)), forControlEvents:  UIControlEvents.TouchUpInside)
////        favoritesButton.hidden = true;
    }
    
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
    
    var player: AVAudioPlayer?
    
//    func playSound(button: UIButton) throws{
//        let fileName = wordNameLabel.text! + " 1"
////        if let audioFileURL = NSBundle.mainBundle().URLForResource(fileName, withExtension: "mp3", subdirectory: "google-audio-files") {
////            do {
////                player = try AVAudioPlayer(contentsOfURL: audioFileURL)
////                guard let player = player else { return }
////    
////                player.prepareToPlay()
////                player.play()
////            } catch let error as NSError {
////                print(error.description)
////            }
////        }
//        else{
//            throw PlayAudioError.FileNotFound(fileName);
//            self.makeToast("抱歉，这个单词没有语音");
//        }
//    }
    
    func favoriteButtonClicked(button: UIButton){
//        DataStore.get().addWordToFavorites(word!);
//        self.window!.makeToast(word!.wordName! + "加入了生词库", duration: 0.5, position: .Bottom)
    }
    
    func setCellWord(word: Word){
        self.word = word;
        self.wordNameLabel.text = word.wordName
        self.definitionLabel.text = word.definition
        if(word.partOfSpeech != nil){
            self.partOfSpeechLabel.text = word.partOfSpeech
        }
//        if(word.pronunciation != nil){
//            self.partOfSpeechLabel.text = self.partOfSpeechLabel.text!.stringByAppendingString("[" + word.pronunciation! + "]")
//        }
    }
    
}
