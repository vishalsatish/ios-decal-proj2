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
    var buttonArray: [UIButton] = [UIButton]()
    var currentButton: UIButton!
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadInterface()
        startGame.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed(sender: UIButton) {
        if currentButton != nil {
            currentButton.backgroundColor = UIColor.whiteColor()
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
    
    func loadInterface() {
        self.buttonArray = [self.button1, self.button2, self.button3, self.button4, self.button5]
        for (var i = 0; i < buttonArray.count; i++) {
            buttonArray[i].layer.cornerRadius = 5.0
            buttonArray[i].layer.borderColor = UIColor.blackColor().CGColor
            buttonArray[i].layer.borderWidth = 1.0
            buttonArray[i].addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let receiver = segue.destinationViewController as? UINavigationController {
            if let destination = receiver.viewControllers.first as? GameViewController {
                destination.category = category
            }
        }
    }
    
}
