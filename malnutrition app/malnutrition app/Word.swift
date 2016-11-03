//
//  Word.swift
//  YanDingiOSApp
//
//  Created by Bowen Jin on 8/30/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation

class Word:NSObject, NSCoding {
    var indexNumber:Int?;
    var wordName: String?;
    var definition: String?;
    var pronunciation: String?;
    var partOfSpeech: String?;
    
    init(newName:String, newDefinition: String){
        wordName = newName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet());
        definition = newDefinition.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet());
    }
    
    init(indexNumber:Int?, wordName: String, definition:String, pronunciation: String?, partOfSpeech: String?){
        self.indexNumber = indexNumber
        self.wordName = wordName
        self.definition = definition
        self.pronunciation = pronunciation
        self.partOfSpeech = partOfSpeech
    }
    
    required init(coder aDecoder: NSCoder) {
        indexNumber = aDecoder.decodeIntegerForKey("indexNumber")
        wordName = (aDecoder.decodeObjectForKey("wordName") as! String)
        definition = (aDecoder.decodeObjectForKey("definition") as! String)
        pronunciation = (aDecoder.decodeObjectForKey("pronunciation") as? String)
        partOfSpeech = (aDecoder.decodeObjectForKey("partOfSpeech") as? String)
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if(indexNumber != nil){
            aCoder.encodeInteger(indexNumber!, forKey: "indexNumber")
        }
        if(wordName != nil){
            aCoder.encodeObject(wordName!, forKey: "wordName")
        }
        if(definition != nil){
            aCoder.encodeObject(definition!, forKey: "definition")
        }
        if(pronunciation != nil){
            aCoder.encodeObject(pronunciation!, forKey: "pronunciation")
        }
        if(partOfSpeech != nil){
            aCoder.encodeObject(partOfSpeech!, forKey: "partOfSpeech")
        }
    }
    
}