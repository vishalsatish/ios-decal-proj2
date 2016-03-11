//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var a: UIButton!
    @IBOutlet var b: UIButton!
    @IBOutlet var c: UIButton!
    @IBOutlet var d: UIButton!
    @IBOutlet var e: UIButton!
    @IBOutlet var f: UIButton!
    @IBOutlet var g: UIButton!
    @IBOutlet var h: UIButton!
    @IBOutlet var i: UIButton!
    @IBOutlet var j: UIButton!
    @IBOutlet var k: UIButton!
    @IBOutlet var l: UIButton!
    @IBOutlet var m: UIButton!
    @IBOutlet var n: UIButton!
    @IBOutlet var o: UIButton!
    @IBOutlet var p: UIButton!
    @IBOutlet var q: UIButton!
    @IBOutlet var r: UIButton!
    @IBOutlet var s: UIButton!
    @IBOutlet var t: UIButton!
    @IBOutlet var u: UIButton!
    @IBOutlet var v: UIButton!
    @IBOutlet var w: UIButton!
    @IBOutlet var x: UIButton!
    @IBOutlet var y: UIButton!
    @IBOutlet var z: UIButton!
    @IBOutlet var puzzle: UILabel!
    @IBOutlet var incorrectGuesses: UILabel!
    @IBOutlet weak var hangmanState: UIImageView!
    @IBOutlet var guessButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    var buttonArray: [UIButton] = [UIButton]()
    var guesses: [UIButton] = [UIButton]()
    var guess: UIButton!
    var numGuess: Int = 0
    var locations = [Character: [Int]]()
    var phrase: String = ""
    var category: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
        let hangmanPhrases = HangmanPhrases(category: category)
        phrase = hangmanPhrases.getRandomPhrase()
        setUpPuzzle()
        print(phrase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Setup
    
    func setUpPuzzle() {
        var text = String()
        for (index, char) in phrase.characters.enumerate() {
            if char == " " {
                text.append(char)
            } else {
                let temp: Character = "-"
                text.append(temp)
                if let _ = locations[char] {
                    locations[char]?.append(index)
                } else {
                    locations[char] = [index]
                }
            }
        }
        puzzle.text = text
        guessButton.enabled = false
        restartButton.enabled = false
    }
    
    func loadInterface() {
        hangmanState.image = UIImage(named: "hangman1.gif")
        self.buttonArray = [self.a, self.b, self.c, self.d, self.e, self.f, self.g, self.h, self.i, self.j, self.k, self.l, self.m, self.n, self.o, self.p, self.q, self.r, self.s, self.t, self.u, self.v, self.w, self.x, self.y, self.z]
        for (var i = 0; i < buttonArray.count; i++) {
            buttonArray[i].addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        }
        guessButton.addTarget(self, action: "guessPressed", forControlEvents: .TouchUpInside)
    }
    
    
    // MARK: - Game Logic
    
    func buttonPressed(sender: UIButton) {
        if guess != nil && !guesses.contains(guess) {
            guess.backgroundColor = UIColor.whiteColor()
        }
        guess = sender
        sender.backgroundColor = UIColor.yellowColor()
        guessButton.enabled = true
    }
    
    func guessPressed() {
        let temp: Character = Character(guess.titleLabel!.text!)
        if let val = locations[temp] {
            for (index, _) in puzzle.text!.characters.enumerate() {
                if val.contains(index) {
                    var chars = Array(puzzle.text!.characters)
                    chars[index] = temp
                    puzzle.text! = String(chars)
                }
            }
        } else {
            incorrectPressed()
        }
        guess.backgroundColor = UIColor.whiteColor()
        guess.enabled = false
        guessButton.enabled = false
        if puzzle.text! == phrase {
            gameFinished(true)
            disableButtons()
        }
        restartButton.enabled = true
    }

    func incorrectPressed() {
        numGuess += 1
        let temp: Character = Character(guess.titleLabel!.text!)
        let blank: Character = " "
        incorrectGuesses.text!.append(blank)
        incorrectGuesses.text!.append(temp)
        guesses.append(guess)
        switch(numGuess) {
        case 1 :
            hangmanState.image = UIImage(named: "hangman2.gif")
            break
        case 2 :
            hangmanState.image = UIImage(named: "hangman3.gif")
            break
        case 3 :
            hangmanState.image = UIImage(named: "hangman4.gif")
            break
        case 4 :
            hangmanState.image = UIImage(named: "hangman5.gif")
            break
        case 5 :
            hangmanState.image = UIImage(named: "hangman6.gif")
            break
        default :
            hangmanState.image = UIImage(named: "hangman7.gif")
            gameFinished(false)
            disableButtons()
        }
    }
    
    func gameFinished(won: Bool) {
        var titleText: String
        var messageText: String
        var yesText: String
        var noText: String
        
        if won {
            titleText = "You win!"
            messageText = "Would you like to play again?"
            yesText = "Yes"
            noText = "No"
        } else {
            titleText = "You lose!"
            messageText = "The correct answer was" + phrase
            yesText = "Play Again"
            noText = "Quit"
        }
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .Alert)
        let yesAction = UIAlertAction(title: yesText, style: .Default) { (action) in
            self.reset()
            self.locations.removeAll()
            self.viewDidLoad()
        }
        alertController.addAction(yesAction)
        
        let noAction = UIAlertAction(title: noText, style: .Default) { (action) in
            self.performSegueWithIdentifier("quitGame", sender: nil)
        }
        alertController.addAction(noAction)
        
        self.presentViewController(alertController, animated: true) {
        }
    }
    
    func reset() {
        numGuess = 0
        incorrectGuesses.text! = "Incorrect Guesses:"
        guess.backgroundColor = UIColor.whiteColor()
        guesses = []
        enableButtons()
        setUpPuzzle()
    }
    
    func enableButtons() {
        for (var i = 0; i < buttonArray.count; i++) {
            buttonArray[i].enabled = true
        }
    }
    
    func disableButtons() {
        for (var i = 0; i < buttonArray.count; i++) {
            buttonArray[i].enabled = false
        }
    }
    
    @IBAction func startOver() {
        let alertController = UIAlertController(title: "Start Over", message: "Are you sure you want to start over?", preferredStyle: .Alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            self.reset()
        }
        alertController.addAction(yesAction)
        
        let noAction = UIAlertAction(title: "No", style: .Cancel) { (action) in
        }
        alertController.addAction(noAction)
        
        self.presentViewController(alertController, animated: true) {
        }
    }
    
    @IBAction func quit() {
        let alertController = UIAlertController(title: "Quit Game", message: "Are you sure you want to quit?", preferredStyle: .Alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            self.performSegueWithIdentifier("quitGame", sender: nil)
        }
        alertController.addAction(yesAction)
        
        let noAction = UIAlertAction(title: "No", style: .Cancel) { (action) in
        }
        alertController.addAction(noAction)
        
        self.presentViewController(alertController, animated: true) {
        }
    }

}
