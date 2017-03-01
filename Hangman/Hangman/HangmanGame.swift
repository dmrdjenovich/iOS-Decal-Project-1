//
//  HangmanGame.swift
//
//  Created by David Mrdjenovich on 3/3/16.
//  Copyright © 2016 David Mrdjenovich. All rights reserved.
//

import Foundation

class HangmanGame {
    
    public var phrase : String;
    public var tokens : NSMutableSet;
    public var successes : NSMutableSet;
    public var errors : NSMutableSet;
    
    // Initialize HangmanPhrase with an array of all possible phrases of the Hangman game
    init() {
        let path = Bundle.main.path(forResource: "phrases", ofType: "plist");
        let phrases = NSArray.init(contentsOfFile: path!);
        let index = Int(arc4random_uniform(UInt32(phrases!.count)));
        phrase = phrases!.object(at: index) as! String;
        print(phrase);
        tokens = NSMutableSet();
        for c in phrase.characters {
            if c != Character(" ") {
                tokens.add(c);
            }
        }
        successes = NSMutableSet();
        errors = NSMutableSet();
    }
    func guess (letter : Character) -> Bool? {
        if successes.contains(letter) || errors.contains(letter) {return nil;}
        if tokens.contains(letter) {
            successes.add(letter);
            return true;
        }
        errors.add(letter);
        return false;
    }
    func getGuessString () -> String {
        var toReturn : String = "";
        for c in phrase.characters {
            if c == Character(" ") {
                toReturn += "   ";
                continue;
            }
            if successes.contains(c) {
                toReturn += String(c) + " ";
            }
            else {
                toReturn += "_ ";
            }
        }
        return toReturn;
    }
    func gameResults () -> Bool? {
        if errors.count >= 6 {
            return false;
        }
        if successes.count == tokens.count {
            return true;
        }
        return nil;
    }
    
}
