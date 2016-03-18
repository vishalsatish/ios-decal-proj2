//
//  StartScreenViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleImage.image = UIImage(named: "hangman1h.png")
        backgroundImage.image = UIImage(named: "background.png")
        self.view.sendSubviewToBack(backgroundImage)
        newGameButton.layer.cornerRadius = 5.0
        newGameButton.layer.borderColor = UIColor.blackColor().CGColor
        newGameButton.layer.borderWidth = 1.0
        newGameButton.backgroundColor = UIColor(red: 195.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        newGameButton.tintColor = UIColor.blackColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToStartScreenViewController(sender: UIStoryboardSegue) {
        
    }

}
