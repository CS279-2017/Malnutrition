//
//  NoteBook.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation

class NoteBook: NSObject, NSCoding{
    var notes = [String: Note]();
    
    override init(){
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(notes, forKey: "notes")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.notes = aDecoder.decodeObject(forKey: "notes") as! [String: Note];
    }
    
    func addNote(note: Note){
        notes[note.title] = note;
    }
    
    func get(title:String) -> Note{
        return notes[title]!;
    }
    
    func size() -> Int{
        return notes.count;
    }
    
//    func getAllNotes() -> [Note]{
//        var allNotes = [Note]();
//        for key in notes{
//            allNotes.append(notes[key]);
//        }
//        return allNotes;
//    }
}
