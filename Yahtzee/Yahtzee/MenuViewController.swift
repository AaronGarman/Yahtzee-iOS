//
//  MenuViewController.swift
//  Yahtzee
//
//  Created by Aaron Garman on 9/19/24.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highScoreLabel.layer.cornerRadius = 10
        highScoreLabel.layer.masksToBounds = true
        
        let defaults = UserDefaults.standard
        //defaults.set(101, forKey: "HighScore")
        let highScore = defaults.integer(forKey: "HighScore")
        highScoreLabel.text = String(highScore)

    }
}
