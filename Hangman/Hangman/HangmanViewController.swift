//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    var exitButton : ExitButton? = nil;
    var newGameButton : NewGameButton? = nil;
    var guessButton : GuessButton? = nil;
    var keyboardButtons : Array<KeyboardButton?>? = nil;
    var statusLabel : StatusLabel? = nil;
    var incorrectGuessesLabel : IncorrectGuessesLabel? = nil;
    var guessLabel : GuessLabel? = nil;
    var nooseGraphic : NooseGraphic? = nil;
    
    var hangmanGame : HangmanGame? = nil;
    
    var currentGuess : Character? = nil;
    
    func exitGameClicked () -> Void {
        exit(0)
    }
    func newGameClicked () -> Void {
        reset();
    }
    func keyboardClicked (input : Character) -> Void {
        currentGuess = input;
        guessLabel!.displayGuess(guess:input);
    }
    func guessClicked () -> Void {
        if let guess = currentGuess {
            let response = hangmanGame!.guess(letter:guess);
            if response != nil {
                statusLabel!.setText(text:hangmanGame!.getGuessString());
                nooseGraphic!.setGraphic(errors: hangmanGame!.errors.count);
                if !response! {incorrectGuessesLabel!.addGuess(guess: guess);}
                if let results = hangmanGame!.gameResults() {
                    if results {
                        alert(title:"CONGRATULATIONS\nYou Win!", message:"Correct Answer: " + hangmanGame!.phrase)
                    }
                    else {
                        alert(title:"Unfortunately...\nYou Lose", message:"Correct Answer: " + hangmanGame!.phrase)
                    }
                }
            }
            guessLabel!.displayGuess(guess: Character(" "));
            currentGuess = nil;
        }
    }
    
    func alert (title : String, message : String) -> Void {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler : alertHandler))
        present(alertController, animated: true, completion: nil);
    }
    
    func alertHandler (act : UIAlertAction) -> Void {
        reset();
    }
    
    func reset () -> Void {
        //Starts a new game without repositioning any controls.
        hangmanGame = HangmanGame();
        nooseGraphic!.setGraphic(errors: 0);
        statusLabel!.setText(text: hangmanGame!.getGuessString());
        incorrectGuessesLabel!.reset();
        guessLabel!.displayGuess(guess: Character(" "));
    }
    func setup () -> Void {
        //Positions controls onto the view and initializes the components.
        view.backgroundColor = UIColor.white;
        
        hangmanGame = HangmanGame();
        
        let PX : Int = 10;
        let PYT : Int = 25;
        let PYB : Int = 15;
        let W : Int = Int(view.bounds.width);
        let H : Int = Int(view.bounds.height);
        let TH : Int = (H - H/3 - PYT - PYB) / 16;  // standard text height.
        
        exitButton = ExitButton(frame:CGRect(
            x:PX,
            y:PYT,
            width:(W - 2*PX)/2,
            height:TH),
                                vc:self);
        view.addSubview(exitButton!);
        newGameButton = NewGameButton(  frame:CGRect(
            x:W - PX - (W - 2*PX)/2,
            y:PYT,
            width:(W-2*PX)/2,
            height:TH),
                                        vc:self);
        view.addSubview(newGameButton!);
        nooseGraphic = NooseGraphic(frame:CGRect(
            x:PX,
            y:TH*3/2 + PYT,
            width:W - 2*PX,
            height:H/3),
                                    vc:self);
        nooseGraphic?.setGraphic(errors: 0);
        view.addSubview(nooseGraphic!);
        statusLabel = StatusLabel(frame:CGRect(
            x:PX,
            y:TH*2 + H/3 + PYT,
            width:W - 2*PX,
            height:TH),
                                  text:hangmanGame!.getGuessString(),
                                  vc:self);
        view.addSubview(statusLabel!);
        incorrectGuessesLabel = IncorrectGuessesLabel(  frame:CGRect(
            x:PX,
            y:TH*4 + H/3 + PYT,
            width:W - 2*PX,
            height:TH),
                                                        vc:self);
        view.addSubview(incorrectGuessesLabel!);
        guessLabel = GuessLabel(    frame:CGRect(
            x:PX,
            y:TH*11/2 + H/3 + PYT,
            width:W - 2*PX,
            height:TH),
                                    vc:self);
        view.addSubview(guessLabel!);
        
        var placed : Int = 0;
        var alphabet : Array<String> = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
        let keyPadding : Int = 5;
        let keyWidth : Int = (W - 2*PX - 6*keyPadding)/7;
        var keyY : Int = TH*8 + H/3 + PYT;
        keyboardButtons = [];
        while placed < 26 {
            for i in 0 ..< 7 {
                if placed >= 26 {break;}
                if 26 - placed < 7 - 2*i {
                    print("continuing: " + String(placed));
                    continue;
                }
                let xPos : Int = PX + i*(keyPadding + keyWidth);
                let letter : String = alphabet[placed];
                let keyButton : KeyboardButton = KeyboardButton(frame:CGRect(
                    x:xPos,
                    y:keyY,
                    width:keyWidth,
                    height:TH),
                                                                text:letter,
                                                                vc:self);
                keyboardButtons!.append(keyButton);
                view.addSubview(keyButton);
                placed += 1;
            }
            keyY += 3*TH/2;
        }
        
        guessButton = GuessButton(  frame:CGRect(
            x:PX,
            y:keyY + TH,
            width:W - 2*PX,
            height:TH),
                                    vc:self);
        view.addSubview(guessButton!);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup();
    }

}

extension UILabel {
    func fillText () -> Void {
        if let t : String = text {
            let finalSize : Int = t.getFontSize(
                bounds : CGSize(width:bounds.width, height:bounds.height),
                font : font
            );
            font = UIFont(name:font.fontName, size:CGFloat(finalSize));
        }
    }
}

extension String {
    func getFontSize (bounds : CGSize, font : UIFont) -> Int {
        var min : Int = 1;
        var max : Int = 200;
        while (min + 1 != max) {
            let trying : Int = (max + min) / 2;
            let fTrying = UIFont(name:font.fontName, size:CGFloat(trying));
            let tBounds : CGSize = getPixelSize(font:fTrying!);
            if (tBounds.height > bounds.height || tBounds.width > bounds.width) {
                max = trying;
            }
            else {
                min = trying;
            }
        }
        return min;
    }
    func getPixelSize (font : UIFont) -> CGSize {
        let boundingBox = (self as NSString).boundingRect(
            with: CGSize(width: Double.greatestFiniteMagnitude, height: Double.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font],
            context: nil).size;
        return boundingBox;
    }
}
