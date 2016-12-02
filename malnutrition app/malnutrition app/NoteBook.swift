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
    
    func deleteNote(note: Note){
        notes.removeValue(forKey: note.title);
    }
    
    func get(title:String) -> Note?{
        return notes[title];
    }
    
    func getNotesWithPrefix(prefix: String)-> [Note]{
        var returnArray = [Note]();
        for note in notes{
            if(note.value.title.hasPrefix(prefix)){
                returnArray.append(note.value);
            }
        }
        return returnArray;
    }
    
    func size() -> Int{
        return notes.count;
    }
    
    //returns notes in descending order by date
    func getAllNotes() -> [Note]{
        var allNotes = [Note]();
        for (title, note) in notes{
            allNotes.append(note)
        }
        allNotes.sort(by: {$0.dateCreated > $1.dateCreated});
        return allNotes;
    }
}
