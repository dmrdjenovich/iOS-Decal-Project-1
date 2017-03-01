//
//  NooseGraphic.swift
//  Hangman
//
//  Created by David Mrdjenovich on 2/28/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import UIKit

class NooseGraphic : UIImageView {
    
    var vc : HangmanViewController
    
    init (frame : CGRect, vc : HangmanViewController) {
        self.vc = vc;
        super.init(frame:frame);
        contentMode = .scaleAspectFit;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGraphic (errors : Int) -> Void {
        if (errors == 0) {
            image = #imageLiteral(resourceName: "hangman1");
        }
        else if (errors == 1) {
            image = #imageLiteral(resourceName: "hangman2");
        }
        else if (errors == 2) {
            image = #imageLiteral(resourceName: "hangman3");
        }
        else if (errors == 3) {
            image = #imageLiteral(resourceName: "hangman4");
        }
        else if (errors == 4) {
            image = #imageLiteral(resourceName: "hangman5");
        }
        else if (errors == 5) {
            image = #imageLiteral(resourceName: "hangman6");
        }
        else {
            image = #imageLiteral(resourceName: "hangman7");
        }
    }
    
}
