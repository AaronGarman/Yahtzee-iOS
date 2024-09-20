//
//  ViewController.swift
//  Yahtzee
//
//  Created by Aaron Garman on 9/18/24.
//

import UIKit

class GameViewController: UIViewController {
    
    var player = Player()
    
    // dice buttons
    
    @IBOutlet weak var diceOneButton: UIButton!
    @IBOutlet weak var diceTwoButton: UIButton!
    @IBOutlet weak var diceThreeButton: UIButton!
    @IBOutlet weak var diceFourButton: UIButton!
    @IBOutlet weak var diceFiveButton: UIButton!
    
    // upper scoring buttons
    
    @IBOutlet weak var onesButton: UIButton!
    @IBOutlet weak var twosButton: UIButton!
    @IBOutlet weak var threesButton: UIButton!
    @IBOutlet weak var foursButton: UIButton!
    @IBOutlet weak var fivesButton: UIButton!
    @IBOutlet weak var sixesButton: UIButton!
    @IBOutlet weak var bonusButton: UIButton! // disabled or as label? keep button so same styling?
    
    // lower scoring buttons
    
    @IBOutlet weak var threeOfKindButton: UIButton!
    @IBOutlet weak var fourOfKindButton: UIButton!
    @IBOutlet weak var fullHouseButton: UIButton!
    @IBOutlet weak var smallStraightButton: UIButton!
    @IBOutlet weak var largeStraightButton: UIButton!
    @IBOutlet weak var yahtzeeButton: UIButton!
    @IBOutlet weak var chanceButton: UIButton!
    
    // info labels
    
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    @IBAction func didTapRollButton(_ sender: UIButton) {
        
        /*
        // put this elsewhere?
        for i in 0...6 {
            if player.upperScoring[i].isActive {
                player.upperScoring[i].value = 0
            }
            
            if player.lowerScoring[i].isActive {
                player.lowerScoring[i].value = 0
            }
        } */
        
        rollDice()
        updateScores()
    }
    
    @IBAction func didTapDiceButton(_ sender: UIButton) {
        if sender == diceOneButton {
            updateDiceButton(diceButton: sender, index: 0)
            print("dice 1")
        }
        else if sender == diceTwoButton {
            updateDiceButton(diceButton: sender, index: 1)
            print("dice 2")
        }
        else if sender == diceThreeButton {
            updateDiceButton(diceButton: sender, index: 2)
            print("dice 3")
        }
        else if sender == diceFourButton {
            updateDiceButton(diceButton: sender, index: 3)
            print("dice 4")
        }
        else if sender == diceFiveButton {
            updateDiceButton(diceButton: sender, index: 4)
            print("dice 5")
        }
        else {
            print("Unknown source - dice buttons")
        }
        
        // any way just 1 func call n above just do index? eh, no want handle diff value?
    }
    
    @IBAction func didTapScoreButton(_ sender: UIButton) {
        if sender == onesButton {
            addScore(scoreButton: sender, index: 0, scoreType: "upper")
            print("ones button")
        }
        else if sender == twosButton {
            addScore(scoreButton: sender, index: 1, scoreType: "upper")
            print("twos button")
        }
        else if sender == threesButton {
            addScore(scoreButton: sender, index: 2, scoreType: "upper")
            print("threes button")
        }
        else if sender == foursButton {
            addScore(scoreButton: sender, index: 3, scoreType: "upper")
            print("fours button")
        }
        else if sender == fivesButton {
            addScore(scoreButton: sender, index: 4, scoreType: "upper")
            print("fives button")
        }
        else if sender == sixesButton {
            addScore(scoreButton: sender, index: 5, scoreType: "upper")
            print("sixes button")
        }
        else if sender == bonusButton {
            //addScore(scoreButton: sender, index: 6, scoreType: "upper")
            print("bonus button")
        }
        else if sender == threeOfKindButton {
            addScore(scoreButton: sender, index: 0, scoreType: "lower")
            print("3x button")
        }
        else if sender == fourOfKindButton {
            addScore(scoreButton: sender, index: 1, scoreType: "lower")
            print("4x button")
        }
        else if sender == fullHouseButton {
            addScore(scoreButton: sender, index: 2, scoreType: "lower")
            print("full h button")
        }
        else if sender == smallStraightButton {
            addScore(scoreButton: sender, index: 3, scoreType: "lower")
            print("sm button")
        }
        else if sender == largeStraightButton {
            addScore(scoreButton: sender, index: 4, scoreType: "lower")
            print("lg button")
        }
        else if sender == yahtzeeButton {
            addScore(scoreButton: sender, index: 5, scoreType: "lower")
            print("ytz button")
        }
        else if sender == chanceButton {
            addScore(scoreButton: sender, index: 6, scoreType: "lower")
            print("chnc button")
        }
        else {
            print("Unknown source - score buttons")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // var upperScoringButtons = [onesButton, twosButton, threesButton] declare above n assign here
        // do for dice too
        // 5 places it would be less lines, also do arr 7 or 14?
        
        
    }

    func rollDice() {
        
        clearScoreButtons() // right? clear at start of roll?
        
        for i in 0...4 {
            if !player.diceRack[i].isLocked {
                player.diceRack[i].value = Int.random(in: 1...6)
            }
        }
        
        diceOneButton.setImage(UIImage(systemName: "die.face.\(player.diceRack[0].value)"), for: .normal)
        diceTwoButton.setImage(UIImage(systemName: "die.face.\(player.diceRack[1].value)"), for: .normal)
        diceThreeButton.setImage(UIImage(systemName: "die.face.\(player.diceRack[2].value)"), for: .normal)
        diceFourButton.setImage(UIImage(systemName: "die.face.\(player.diceRack[3].value)"), for: .normal)
        diceFiveButton.setImage(UIImage(systemName: "die.face.\(player.diceRack[4].value)"), for: .normal)
        
        printDice()
    }
    
    func updateDiceButton(diceButton: UIButton, index: Int) {  // diff name?
        
        player.diceRack[index].isLocked.toggle() // toggle ok?
        
        if diceButton.tintColor == .black {
            diceButton.tintColor = .red
        }
        else {
            diceButton.tintColor = .black
        }
    }
    
    func updateScores() { // do as upper n lower? call update v check?
        
        // total value for all current dice
        
        // maybe array?
        var onesValue = 0, twosValue = 0, threesValue = 0, foursValue = 0, fivesValue = 0, sixesValue = 0 // sep lines?
        var totalValue = 0
        
        // calculate dice values
        
        for dice in player.diceRack {
            if dice.value == 1 {
                onesValue += dice.value
            }
            else if dice.value == 2 {
                twosValue += dice.value
            }
            else if dice.value == 3 {
                threesValue += dice.value
            }
            else if dice.value == 4{
                foursValue += dice.value
            }
            else if dice.value == 5 {
                fivesValue += dice.value
            }
            else {
                sixesValue += dice.value
            }
            
            totalValue += dice.value
        }
        
        // upper scoring
        
        if player.upperScoring[0].isActive {
            player.upperScoring[0].value = onesValue
        }
        if player.upperScoring[1].isActive {
            player.upperScoring[1].value = twosValue
        }
        if player.upperScoring[2].isActive {
            player.upperScoring[2].value = threesValue
        }
        if player.upperScoring[3].isActive {
            player.upperScoring[3].value = foursValue
        }
        if player.upperScoring[4].isActive {
            player.upperScoring[4].value = fivesValue
        }
        if player.upperScoring[5].isActive {
            player.upperScoring[5].value = sixesValue
        }
        
        // lower scoring
        
        // 3 of a kind
        
        if player.lowerScoring[0].isActive {
            if onesValue >= 3 || twosValue >= 6 || threesValue >= 9 || foursValue >= 12 || fivesValue >= 15 || sixesValue >= 18 {
                player.lowerScoring[0].value = totalValue
            }
        }
        
        // 4 of a kind
        
        if player.lowerScoring[1].isActive {
            if onesValue >= 4 || twosValue >= 8 || threesValue >= 12 || foursValue >= 16 || fivesValue >= 20 || sixesValue >= 24 {
                player.lowerScoring[1].value = totalValue
            }
        }
        
        // full house - sep ifs or as and?
        
        if player.lowerScoring[2].isActive {
            if onesValue == 3 {
                if twosValue == 4 || threesValue == 6 || foursValue == 8 || fivesValue == 10 || sixesValue == 12 {
                    player.lowerScoring[2].value = 25
                }
            }
            else if twosValue == 6 {
                if onesValue == 2 || threesValue == 6 || foursValue == 8 || fivesValue == 10 || sixesValue == 12 {
                    player.lowerScoring[2].value = 25
                }
            }
            else if threesValue == 9 {
                if onesValue == 2 || twosValue == 4 || foursValue == 8 || fivesValue == 10 || sixesValue == 12 {
                    player.lowerScoring[2].value = 25
                }
            }
            else if foursValue == 12 {
                if onesValue == 2 || twosValue == 4 || threesValue == 6 || fivesValue == 10 || sixesValue == 12 {
                    player.lowerScoring[2].value = 25
                }
            }
            else if fivesValue == 15 {
                if onesValue == 2 || twosValue == 4 || threesValue == 6 || foursValue == 8 ||  sixesValue == 12 {
                    player.lowerScoring[2].value = 25
                }
            }
            else if sixesValue == 18 {
                if onesValue == 2 || twosValue == 4 || threesValue == 6 || foursValue == 8 || fivesValue == 10 {
                    player.lowerScoring[2].value = 25
                }
            }
        }
        
        // small straight
        
        if player.lowerScoring[3].isActive {
            if (onesValue >= 1 && twosValue >= 2 && threesValue >= 3 && foursValue >= 4) || (twosValue >= 2 && threesValue >= 3 && foursValue >= 4 && fivesValue >= 5) || (threesValue >= 3 && foursValue >= 4 && fivesValue >= 5 && sixesValue >= 6) {
                player.lowerScoring[3].value = 30
            }
        }
        
        // large straight
        
        if player.lowerScoring[4].isActive {
            if (onesValue == 1 && twosValue == 2 && threesValue == 3 && foursValue == 4 && fivesValue == 5) || (twosValue == 2 && threesValue == 3 && foursValue == 4 && fivesValue == 5 && sixesValue == 6)  {
                player.lowerScoring[4].value = 40
            }
        }
        
        // yahtzee - might need to adjust isActive based on 2nd yahtzee
        
        if player.lowerScoring[5].isActive {
            if onesValue == 5 || twosValue == 10 || threesValue == 15 || foursValue == 20 || fivesValue == 25 || sixesValue == 30 {
                player.lowerScoring[5].value = 50
            }
        }
        
        // chance
        
        if player.lowerScoring[6].isActive {
            player.lowerScoring[6].value = totalValue
        }
        
      // more funcs for stuff?
    
        updateScoreLabels()
        //addScore() // call here or diff?
    }
    
    func updateScoreLabels() {
        onesButton.setTitle(String(player.upperScoring[0].value), for: .normal)
        twosButton.setTitle(String(player.upperScoring[1].value), for: .normal)
        threesButton.setTitle(String(player.upperScoring[2].value), for: .normal)
        foursButton.setTitle(String(player.upperScoring[3].value), for: .normal)
        fivesButton.setTitle(String(player.upperScoring[4].value), for: .normal)
        sixesButton.setTitle(String(player.upperScoring[5].value), for: .normal)
        bonusButton.setTitle(String(player.upperScoring[6].value), for: .normal)
        
        threeOfKindButton.setTitle(String(player.lowerScoring[0].value), for: .normal)
        fourOfKindButton.setTitle(String(player.lowerScoring[1].value), for: .normal)
        fullHouseButton.setTitle(String(player.lowerScoring[2].value), for: .normal)
        smallStraightButton.setTitle(String(player.lowerScoring[3].value), for: .normal)
        largeStraightButton.setTitle(String(player.lowerScoring[4].value), for: .normal)
        yahtzeeButton.setTitle(String(player.lowerScoring[5].value), for: .normal)
        chanceButton.setTitle(String(player.lowerScoring[6].value), for: .normal)
    }
    
    // diff name?
    func addScore(scoreButton: UIButton, index: Int, scoreType: String) { // put stuff in order, any to above? if do above if even need? just disable? if no disable keep here so only write once? do as guard let? either do bool or do 14 array
        
        if scoreType == "upper" {
            guard player.upperScoring[index].isActive else { return }
            player.totalScore += player.upperScoring[index].value
            player.upperScoring[index].isActive = false
        }
        else {
            guard player.lowerScoring[index].isActive else { return }
            player.totalScore += player.lowerScoring[index].value
            player.lowerScoring[index].isActive = false
        }
        
        totalScoreLabel.text = String(player.totalScore)
        scoreButton.tintColor = .green // do default once scored?
       
        
        // clear out boxes not scored yet - keep here v somewhere else?
        
        clearScoreButtons()

        updateScoreLabels()
        //scoreButton.isEnabled = false // disable - phsycial or from class data?
        
        // turn below into funcs - reset dice to default (maybe diff than 1?) also reset locks. lock if all 5 dice locked, no roll? bool? disable dice until roll?
        
        resetDice()
        
        // call func above
    }
    
    func clearScoreButtons() {
        for i in 0...6 {
            if player.upperScoring[i].isActive {
                player.upperScoring[i].value = 0
            }
            
            if player.lowerScoring[i].isActive {
                player.lowerScoring[i].value = 0
            }
        }
    }
    
    func resetDice() {
        // any way do any loops? only if put numbers in name? how if not string too? or array of buttons?
        diceOneButton.setImage(UIImage(systemName: "die.face.1"), for: .normal)
        diceTwoButton.setImage(UIImage(systemName: "die.face.1"), for: .normal)
        diceThreeButton.setImage(UIImage(systemName: "die.face.1"), for: .normal)
        diceFourButton.setImage(UIImage(systemName: "die.face.1"), for: .normal)
        diceFiveButton.setImage(UIImage(systemName: "die.face.1"), for: .normal)
        
        diceOneButton.tintColor = .black
        diceTwoButton.tintColor = .black
        diceThreeButton.tintColor = .black
        diceFourButton.tintColor = .black
        diceFiveButton.tintColor = .black
        
        for i in 0...4 {
            player.diceRack[i].isLocked = false
        }
    }
}

// extension for testing & error checking functions

extension GameViewController {
    
    func printDice() { // condense any?
        // space here funcs or no?
        print("dice one: \(player.diceRack[0].value)")
        print("dice two: \(player.diceRack[1].value)")
        print("dice three: \(player.diceRack[2].value)")
        print("dice four: \(player.diceRack[3].value)")
        print("dice five: \(player.diceRack[4].value)")
        
        print(player.diceRack)
    }
    
    func printScores() {
        print("\n1's: \(player.upperScoring[0].value)")
        print("2's: \(player.upperScoring[1].value)")
        print("3's: \(player.upperScoring[2].value)")
        print("4's: \(player.upperScoring[3].value)")
        print("5's: \(player.upperScoring[4].value)")
        print("6's: \(player.upperScoring[5].value)")
        print("Bonus: \(player.upperScoring[6].value)")
        
        print("\n3X: \(player.lowerScoring[0].value)")
        print("4X: \(player.lowerScoring[1].value)")
        print("FullH: \(player.lowerScoring[2].value)")
        print("SmStr: \(player.lowerScoring[3].value)")
        print("LgStr: \(player.lowerScoring[4].value)")
        print("Yatz: \(player.lowerScoring[5].value)")
        print("Chnc: \(player.lowerScoring[6].value)\n")
    }
}

// any other extension?
// do _ for func args?
// maybe just 1 array so no upper n lower need? or do as if?
// put funcs in logical order? clearing funcs last
// if all dice locked no roll n put on label msg?
