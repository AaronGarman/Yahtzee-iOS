//
//  MenuViewController.swift
//  Yahtzee
//
//  Created by Aaron Garman on 9/19/24.
//

import UIKit

class MenuViewController: UIViewController, GameViewControllerDelegate {

    @IBOutlet weak var highScoreLabel: UILabel!
    
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initScoreLabel()
        UpdateScore()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameViewController = segue.destination as? GameViewController {
            gameViewController.delegate = self
        }
    }
    
    func gameDidEnd() {
        UpdateScore()
    }
    
    private func initScoreLabel() {
        highScoreLabel.layer.cornerRadius = 10
        highScoreLabel.layer.masksToBounds = true
    }
    
    private func UpdateScore() {
        let defaults = UserDefaults.standard
        highScore = defaults.integer(forKey: "HighScore")
        highScoreLabel.text = String(highScore)
    }
}
