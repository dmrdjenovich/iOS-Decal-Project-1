//
//  GuessLabel.swift
//  Hangman
//
//  Created by David Mrdjenovich on 2/28/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import UIKit

class GuessLabel : ResizingLabel {
    
    var vc : HangmanViewController
    
    init (frame : CGRect, vc : HangmanViewController) {
        self.vc = vc;
        super.init(frame:frame, text:"Current Guess: ");
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func displayGuess (guess : Character) {
        setText(text : "Current Guess: " + String(guess));
    }
    
}
