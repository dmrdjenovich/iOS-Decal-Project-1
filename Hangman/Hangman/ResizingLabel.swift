//
//  ResizingLabel.swift
//  Hangman
//
//  Created by David Mrdjenovich on 2/26/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import UIKit

class ResizingLabel: UILabel {
    
    init (frame : CGRect, text : String) {
        super.init(frame:frame);
        self.text = text;
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder);
        setup();
    }
    
    public func setText (text : String) {
        self.text = text;
        setup();
    }
    
    private func setup () -> Void {
        if text != nil {
            fillText();
            baselineAdjustment = .alignCenters
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
