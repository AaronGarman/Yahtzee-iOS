//
//  ViewController.swift
//  Yahtzee
//
//  Created by Aaron Garman on 9/18/24.
//

import UIKit

class GameViewController: UIViewController {
    
    var player = Player()
    
    // score buttons for looping style changes
    
    var diceButtons: [UIButton] = []
    var upperScoreButtons: [UIButton] = [] // init here v init func? would buttons even be ready in init?
    var lowerScoreButtons: [UIButton] = []
    
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
        rollDice()
        updateScores()
    }
    
    @IBAction func didTapDiceButton(_ sender: UIButton) {
        var index: Int?
        
        if sender == diceOneButton {
            index = 0
        }
        else if sender == diceTwoButton {
            index = 1
        }
        else if sender == diceThreeButton {
            index = 2
        }
        else if sender == diceFourButton {
            index = 3
        }
        else if sender == diceFiveButton {
            index = 4
        }
        else {
            print("Unknown source - dice buttons")
        }
        
        if let validIndex = index {
            updateDiceButton(diceButton: sender, index: validIndex)
        }
    }
    
    
    @IBAction func didTapScoreButton(_ sender: UIButton) {
        var index: Int?
        var isUpper: Bool?
        
        if sender == onesButton {
            index = 0
            isUpper = true
        }
        else if sender == twosButton {
            index = 1
            isUpper = true
        }
        else if sender == threesButton {
            index = 2
            isUpper = true
        }
        else if sender == foursButton {
            index = 3
            isUpper = true
        }
        else if sender == fivesButton {
            index = 4
            isUpper = true
        }
        else if sender == sixesButton {
            index = 5
            isUpper = true
        }
        else if sender == threeOfKindButton {
            index = 0
            isUpper = false
        }
        else if sender == fourOfKindButton {
            index = 1
            isUpper = true
        }
        else if sender == fullHouseButton {
            index = 2
            isUpper = true
        }
        else if sender == smallStraightButton {
            index = 3
            isUpper = true
        }
        else if sender == largeStraightButton {
            index = 4
            isUpper = true
        }
        else if sender == yahtzeeButton {
            index = 5
            isUpper = true
        }
        else if sender == chanceButton {
            index = 6
            isUpper = true
        }
        else {
            print("Unknown source - score buttons")
        }
        
        if let validIndex = index, let validIsUpper = isUpper {
            addScore(scoreButton: sender, index: validIndex, isUpper: validIsUpper)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 5 places it would be less lines, also do arr 7 or 14?
        
        diceButtons = [diceOneButton, diceTwoButton, diceThreeButton, diceFourButton, diceFiveButton]
        upperScoreButtons = [onesButton, twosButton, threesButton, foursButton, fivesButton, sixesButton, bonusButton]
        lowerScoreButtons = [threeOfKindButton, fourOfKindButton, fullHouseButton, smallStraightButton, largeStraightButton, yahtzeeButton, chanceButton]
    }

    func rollDice() {
        clearScoreButtons() // right? clear at start of roll?
        
        for i in 0...4 {
            if !player.diceRack[i].isLocked {
                player.diceRack[i].value = Int.random(in: 1...6)
                diceButtons[i].setImage(UIImage(systemName: "die.face.\(player.diceRack[i].value)"), for: .normal)
            }
        }
        
        //print(player.diceRack)
    }
    
    func updateDiceButton(diceButton: UIButton, index: Int) {  // diff name?
        player.diceRack[index].isLocked.toggle()
        
        if diceButton.tintColor == .black {
            diceButton.tintColor = .red
        }
        else {
            diceButton.tintColor = .black
        }
    }
    
    func updateScores() {
        
        // total value for all current dice
        
        var onesValue = 0, twosValue = 0, threesValue = 0, foursValue = 0, fivesValue = 0, sixesValue = 0
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
        for i in 0...6 {
            upperScoreButtons[i].setTitle(String(player.upperScoring[i].value), for: .normal)
            lowerScoreButtons[i].setTitle(String(player.lowerScoring[i].value), for: .normal)
        }
    }
    
    // diff name?
    func addScore(scoreButton: UIButton, index: Int, isUpper: Bool) { // put stuff in order, any to above? if do above if even need? just disable? if no disable keep here so only write once? do as guard let? either do bool or do 14 array
        
        if isUpper {
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
        for i in 0...4 {
            diceButtons[i].setImage(UIImage(systemName: "die.face.1"), for: .normal)
            diceButtons[i].tintColor = .black
            
            player.diceRack[i].isLocked = false
        }
    }
}

// if all dice locked no roll n put on label msg?

// put funcs in logical order? clearing funcs last
// condense, any more extensions?
// arrays both 7 v 14 - kinda like 7 tbh? add score func biggest offender - maybe 14 more optimized? or keep 2 arrays prob
// upper n lower string to bool or do array 14
// ib actions maybe array 14 n do index in ifs or func call each?
// maybe just print arrays rather than custom funcs - maybe no need smaller funcs if not called multiple times?
// clear out comments + put comments in
// could do diff handler for upper n lower to keep consistent? how integrate w add score func tho? or still just do type variable but implicit?
