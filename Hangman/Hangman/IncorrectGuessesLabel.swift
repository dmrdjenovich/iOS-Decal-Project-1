//
//  IncorrectGuessesLabel.swift
//  Hangman
//
//  Created by David Mrdjenovich on 2/28/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import UIKit

class IncorrectGuessesLabel : ResizingLabel {
    
    var vc : HangmanViewController
    var iGuesses : Array<Character>;
    
    init (frame : CGRect, vc : HangmanViewController) {
        self.vc = vc;
        iGuesses = [];
        super.init(frame:frame, text:"Incorrect Guesses: ");
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func addGuess (guess : Character) -> Void {
        iGuesses.append(guess);
        refresh();
    }
    
    func reset () -> Void {
        iGuesses = [];
        refresh();
    }
    
    func refresh () -> Void {
        var finalString : String = "Incorrect Guesses: ";
        for i in 0 ..< iGuesses.count {
            finalString += String(iGuesses[i]);
            if (i != iGuesses.count - 1) {
                finalString += ",";
            }
        }
        setText(text: finalString);
    }
}
