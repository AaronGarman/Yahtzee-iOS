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
    
    
    @IBOutlet weak var turnInfoLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    @IBOutlet weak var rollDicebutton: UIButton!
    
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
    
    @IBAction func didTapUpperScoreButton(_ sender: UIButton) {
        var index: Int?
        
        if sender == onesButton {
            index = 0
        }
        else if sender == twosButton {
            index = 1
        }
        else if sender == threesButton {
            index = 2
        }
        else if sender == foursButton {
            index = 3
        }
        else if sender == fivesButton {
            index = 4
        }
        else if sender == sixesButton {
            index = 5
        }
        else {
            print("Unknown source - upper score buttons")
        }
        
        if let validIndex = index {
            addScore(scoreButton: sender, index: validIndex, isUpper: true)
        }
    }
    
    @IBAction func didTapLowerScoreButton(_ sender: UIButton) {
        var index: Int?
        
        if sender == threeOfKindButton {
            index = 0
        }
        else if sender == fourOfKindButton {
            index = 1
        }
        else if sender == fullHouseButton {
            index = 2
        }
        else if sender == smallStraightButton {
            index = 3
        }
        else if sender == largeStraightButton {
            index = 4
        }
        else if sender == yahtzeeButton {
            index = 5
        }
        else if sender == chanceButton {
            index = 6
        }
        else {
            print("Unknown source - lower score buttons")
        }
        
        if let validIndex = index {
            addScore(scoreButton: sender, index: validIndex, isUpper: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bonusButton.isEnabled = false
        
        diceButtons = [diceOneButton, diceTwoButton, diceThreeButton, diceFourButton, diceFiveButton]
        upperScoreButtons = [onesButton, twosButton, threesButton, foursButton, fivesButton, sixesButton, bonusButton]
        lowerScoreButtons = [threeOfKindButton, fourOfKindButton, fullHouseButton, smallStraightButton, largeStraightButton, yahtzeeButton, chanceButton]
        
        disableButtons()

    }
    
    func disableButtons() {
        for diceButton in diceButtons { // put these into func, 2 places call
            diceButton.isEnabled = false
        }
        
        for upperScoreButton in upperScoreButtons { // only lock if not already locked? or no need check?
            upperScoreButton.isEnabled = false
        }
        
        for lowerScoreButton in lowerScoreButtons {
            lowerScoreButton.isEnabled = false
        }
    }

    func rollDice() { // reorder n put stuff into funcs - combine funcs if can, any diff order?
        guard !checkAllDiceLocked() else { return } // check all dice locked
        resetScores() // reset scores to 0 if not scored - right? clear at start of roll? in here also set all buttons to enabled?
        resetButtons() // reset buttons as enabled once start first roll
        
        player.rollCount += 1
        
        // give each dice new value and image
        
        for i in 0...4 {
            if !player.diceRack[i].isLocked {
                player.diceRack[i].value = Int.random(in: 1...6)
                diceButtons[i].setImage(UIImage(systemName: "die.face.\(player.diceRack[i].value)"), for: .normal)
            }
        }
        
        // update turn info - check if last roll in turn
        
        if player.rollCount == 3 {
            rollDicebutton.isEnabled = false
            turnInfoLabel.text = "Select a move to score!"
        }
        else {
            turnInfoLabel.text = "Roll the dice, or score a move!"
        }
        
        // print(player.diceRack)
    }
    
    func checkAllDiceLocked() -> Bool { // check if all dice are locked - might be incomplete?
        for i in 0...4 { // this n more stuff as sep funcs? return bool?
            if player.diceRack[i].isLocked {
                if i < 4 { // maybe only check below?
                    continue
                }
                else {
                    turnInfoLabel.text = "Unlock a dice to roll again!" // diff say?
                    return true
                }
            }
            else {
                break
            }
        }
        
        return false
    }
    
    func resetButtons() {
        guard player.rollCount == 0 else { return } // this here or do if above?
                
        for diceButton in diceButtons {
            diceButton.isEnabled = true
        }
        
        for upperScoreButton in upperScoreButtons {
            upperScoreButton.isEnabled = true // only if not locked? or taken care of? do i even need locks or just disable? still use locks for score calc?
        }
        
        for lowerScoreButton in lowerScoreButtons {
            lowerScoreButton.isEnabled = true // only if not locked? or taken care of? do i even need locks or just disable? still use locks for score calc?
        }
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
        
        // total value for all current dice - could do values on outside n do upper n lower scoring funcs? do as array?
        // or calc here n pass in?
        
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
    
        updateScoreButtons()
        
        // print(player.upperScoring)
        // print(player.lowerScoring)
    }
    
    func updateScoreButtons() {
        for i in 0...6 {
            upperScoreButtons[i].setTitle(String(player.upperScoring[i].value), for: .normal)
            lowerScoreButtons[i].setTitle(String(player.lowerScoring[i].value), for: .normal)
        }
    }
    
    // diff name? addInScore
    func addScore(scoreButton: UIButton, index: Int, isUpper: Bool) { // put stuff in order, any to above? if do above if even need? just disable? if no disable keep here so only write once? do as guard let? either do bool or do 14 array

        if isUpper { // any way combine upper n lower?
            guard player.upperScoring[index].isActive else { return }
            player.totalScore += player.upperScoring[index].value
            player.upperScore += player.upperScoring[index].value // for upper bonus
            player.upperScoring[index].isActive = false
        }
        else {
            guard player.lowerScoring[index].isActive else { return }
            player.totalScore += player.lowerScoring[index].value
            player.lowerScoring[index].isActive = false
        }
        
        totalScoreLabel.text = String(player.totalScore)
        scoreButton.tintColor = .green // do default once scored?
        
        
        // check for double yahtzee here?
        
        // clear out boxes not scored yet - keep here v somewhere else?
        
        resetScores()
        updateScoreButtons() // maybe call in reset scores?
        
        //scoreButton.isEnabled = false // disable - phsycial or from class data?
        
        // lock if all 5 dice locked, no roll? bool?
        
        resetDice()
        
        // disable dice until roll?
        
        rollDicebutton.isEnabled = true // put this into func? below too
        player.rollCount = 0
        player.turnCount += 1
        
        disableButtons()
        
        // need actual add to top score - some stuff no need if rearrange, like adding n labels
        
        if player.upperScore >= 63 && player.bonusActive {
            addBonus()
        }
        
        if player.turnCount == 13 {
            endGame()
            turnInfoLabel.text = ("Game Over! Click reset to play again!") // diff?
        }
        else {
            turnInfoLabel.text = "Roll the dice to start your turn!"
        }
        
    }
    
    func addBonus() {
        player.upperScoring[6].value = 35
        upperScoreButtons[6].setTitle(String(player.upperScoring[6].value), for: .normal)
        player.totalScore += 35
        totalScoreLabel.text = String(player.totalScore) // do this later so no need?
        upperScoreButtons[6].isEnabled = false // no need? if change styling tho, do as sep class? or somethin diff?
        player.bonusActive = false
    }
    
    func endGame() {
        
        // disable roll button since no more turns
        
        rollDicebutton.isEnabled = false // need all these?
        
        // update high score
        
        let defaults = UserDefaults.standard // def this as func
        let oldHighScore = defaults.integer(forKey: "HighScore")
        if player.totalScore > oldHighScore {
            defaults.set(player.totalScore, forKey: "HighScore")
        }
        
        // show reset button n enable? or use dice button n change color?
    }
    
    func resetScores() {
        for i in 0...6 {
            if player.upperScoring[i].isActive {
                player.upperScoring[i].value = 0
            }
            
            if player.lowerScoring[i].isActive {
                player.lowerScoring[i].value = 0
            }
        }
    }
    
    func resetDice() { // could possibly put this into func that calls it?
        for i in 0...4 {
            diceButtons[i].setImage(UIImage(systemName: "die.face.1"), for: .normal)
            diceButtons[i].tintColor = .black
            
            player.diceRack[i].isLocked = false
        }
    }
}

// maybe ext func here to print all values?

// clear out comments + put comments in, clean up
// maybe disabled tint keep same as black? https://stackoverflow.com/questions/45834966/uibutton-tintcolor-for-disabled-and-enabled-state/45835079#45835079
// for buttons class could also do green background when disabled? still need locks for scoring or others?

// mainly just 2 button handlers?
// any func stuff in diff orders? mainly for 2 last handlers?

// more stuff as funcs*** combine any funcs too? focus roll n score funcs flow
// redorder any logic? espec for roll and score handlers

// org n optimize all here + compare w/ java code + add in double yahtzee

// how update score in main menu? closure or delegate prob

// logical order for all funcs?
