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
    @IBOutlet weak var knowButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    var buttonArray: [UIButton] = [UIButton]()
    var guesses: [UIButton] = [UIButton]()
    var guess: UIButton!
    var numGuess: Int = 0
    var locations = [Character: [Int]]()
    var phrase: String = ""
    var category: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        loadButtons()
        loadInterface()
        let hangmanPhrases = HangmanPhrases(category: category)
        phrase = hangmanPhrases.getRandomPhrase()
        setUpPuzzle()
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
        guessButton.backgroundColor = UIColor(red: 195.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 0.5)
        restartButton.enabled = false
    }
    
    func loadButtons() {
        self.buttonArray = [self.a, self.b, self.c, self.d, self.e, self.f, self.g, self.h, self.i, self.j, self.k, self.l, self.m, self.n, self.o, self.p, self.q, self.r, self.s, self.t, self.u, self.v, self.w, self.x, self.y, self.z]
        for (var i = 0; i < buttonArray.count; i++) {
            buttonArray[i].addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        }
        guessButton.addTarget(self, action: "guessPressed", forControlEvents: .TouchUpInside)
    }
    
    func loadInterface() {
        backgroundImage.image = UIImage(named: "background.png")
        self.view.sendSubviewToBack(backgroundImage)
        hangmanState.image = UIImage(named: "hangman1h.png")
        for (var i = 0; i < buttonArray.count; i++) {
            buttonArray[i].layer.cornerRadius = 5.0
            buttonArray[i].layer.borderColor = UIColor.blackColor().CGColor
            buttonArray[i].layer.borderWidth = 1.0
            buttonArray[i].backgroundColor = UIColor(red: 195.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 1.0)
            buttonArray[i].tintColor = UIColor.blackColor()
        }
        guessButton.layer.cornerRadius = 5.0
        knowButton.layer.cornerRadius = 5.0
        guessButton.layer.borderColor = UIColor.blackColor().CGColor
        knowButton.layer.borderColor = UIColor.blackColor().CGColor
        guessButton.layer.borderWidth = 1.0
        knowButton.layer.borderWidth = 1.0
        guessButton.backgroundColor = UIColor(red: 195.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        knowButton.backgroundColor = UIColor(red: 195.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        guessButton.tintColor = UIColor.blackColor()
        knowButton.tintColor = UIColor.blackColor()
        quitButton.tintColor = UIColor(red: 223.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 1.0)
        let b = UIScreen.mainScreen().bounds
        let example = UILabel.init(frame: CGRectMake(b.width/2 - 100, b.height/2 - 275, 200, 75))
        example.backgroundColor = UIColor(red: 195.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        self.view.insertSubview(example, aboveSubview: backgroundImage)
        restartButton.tintColor = UIColor.blackColor()
    }
    
    
    // MARK: - Game Logic
    
    func buttonPressed(sender: UIButton) {
        if guess != nil && !guesses.contains(guess) {
            guess.backgroundColor = UIColor(red: 195.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        }
        guess = sender
        sender.backgroundColor = UIColor.yellowColor()
        guessButton.enabled = true
        guessButton.backgroundColor = UIColor(red: 195.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 1.0)
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
            guess.backgroundColor = UIColor(red: 120.0/255.0, green: 195.0/255.0, blue: 174.0/255.0, alpha: 0.5)
            guess.layer.borderColor = UIColor.lightGrayColor().CGColor
        } else {
            incorrectPressed()
            guess.backgroundColor = UIColor(red: 223.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 0.5)
            guess.layer.borderColor = UIColor.lightGrayColor().CGColor
        }
        guess.enabled = false
        guessButton.enabled = false
        guessButton.backgroundColor = UIColor(red: 195.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 0.5)
        guesses.append(guess)
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
        switch(numGuess) {
        case 1 :
            hangmanState.image = UIImage(named: "hangman2h.png")
            break
        case 2 :
            hangmanState.image = UIImage(named: "hangman3h.png")
            break
        case 3 :
            hangmanState.image = UIImage(named: "hangman4h.png")
            break
        case 4 :
            hangmanState.image = UIImage(named: "hangman5h.png")
            break
        case 5 :
            hangmanState.image = UIImage(named: "hangman6h.png")
            break
        default :
            hangmanState.image = UIImage(named: "hangman7h.png")
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
            messageText = "The correct answer was " + phrase
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
        incorrectGuesses.text! = ""
        guesses = []
        loadInterface()
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
    
    @IBAction func knowIt() {
        let alertController = UIAlertController(title: "I Know It!", message: "Guess the whole world! If you are incorrect, you lose! Proceed?", preferredStyle: .Alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            let yolo = UIAlertController(title: "Enter Guess", message: "Enter your full guess here!", preferredStyle: .Alert)
            yolo.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            })
            yolo.addAction(UIAlertAction(title: "Go!", style: .Default, handler: { (action) -> Void in
                let textField = yolo.textFields![0] as UITextField
                if textField.text?.uppercaseString == self.phrase {
                    self.guess.backgroundColor = UIColor(red: 195.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 1.0)
                    self.puzzle.text = self.phrase
                    self.gameFinished(true)
                } else {
                    self.gameFinished(false)
                }
            }))
            self.presentViewController(yolo, animated: true, completion: nil)
        }
        alertController.addAction(yesAction)
        
        let noAction = UIAlertAction(title: "No", style: .Cancel) { (action) in
        }
        alertController.addAction(noAction)
        
        self.presentViewController(alertController, animated: true) {
        }
    }

}
