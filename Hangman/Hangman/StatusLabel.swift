//
//  StatusLabel.swift
//  Hangman
//
//  Created by David Mrdjenovich on 2/28/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import UIKit

class StatusLabel : ResizingLabel {
    
    var vc : HangmanViewController
    
    init (frame : CGRect, text : String, vc : HangmanViewController) {
        self.vc = vc;
        super.init(frame:frame, text:text);
        textAlignment = .center;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
}
