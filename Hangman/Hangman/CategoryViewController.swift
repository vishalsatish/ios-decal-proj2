//
//  CategoryViewController.swift
//  Hangman
//
//  Created by Vishal Satish on 3/9/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    var buttonArray: [UIButton] = [UIButton]()
    var currentButton: UIButton!
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadButtons()
        loadInterface()
        startGame.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed(sender: UIButton) {
        if currentButton != nil {
            currentButton.backgroundColor = UIColor(red: 195.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        }
        switch(sender) {
            case button1 :
                category = "beatles"
                currentButton = button1
                break
            case button2 :
                category = "berkeley"
                currentButton = button2
                break
            case button3 :
                category = "dogs"
                currentButton = button3
                break
            case button4 :
                category = "superheroes"
                currentButton = button4
                break
            default :
                category = "countries"
                currentButton = button5
        }
        currentButton.backgroundColor = UIColor.yellowColor()
        startGame.enabled = true
    }
    
    func loadButtons() {
        self.buttonArray = [self.button1, self.button2, self.button3, self.button4, self.button5]
        for (var i = 0; i < buttonArray.count; i++) {
            buttonArray[i].layer.cornerRadius = 5.0
            buttonArray[i].layer.borderColor = UIColor.blackColor().CGColor
            buttonArray[i].layer.borderWidth = 1.0
            buttonArray[i].addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        }
    }
    
    func loadInterface() {
        backgroundImage.image = UIImage(named: "background.png")
        self.view.sendSubviewToBack(backgroundImage)
        for (var i = 0; i < buttonArray.count; i++) {
            buttonArray[i].layer.cornerRadius = 5.0
            buttonArray[i].layer.borderColor = UIColor.blackColor().CGColor
            buttonArray[i].layer.borderWidth = 1.0
            buttonArray[i].backgroundColor = UIColor(red: 195.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 1.0)
            buttonArray[i].tintColor = UIColor.blackColor()
        }
        startGame.tintColor = UIColor.blackColor()
        cancelButton.tintColor = UIColor(red: 223.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let receiver = segue.destinationViewController as? GameViewController {
                receiver.category = category
        }
    }
    
}
