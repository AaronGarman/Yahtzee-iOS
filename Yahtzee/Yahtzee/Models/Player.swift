//
//  Player.swift
//  Yahtzee
//
//  Created by Aaron Garman on 9/18/24.
//

import Foundation

struct Player {
    
    // turns
    
    var turnCount = 0
    var rollCount = 0
    
    // dice
    
    var diceRack = (0..<5).map { _ in Dice() } // do as array w/ repeating?
    
    // upper scoring - 1's, 2's, 3's, 4's, 5's, 6's, bonus
    
    var upperScoring = (0..<7).map { _ in ScoreBox() }
    
    // lower scoring - 3X, 4X, full house, sm straight, lg straight, yahtzee, chance
    
    var lowerScoring = (0..<7).map { _ in ScoreBox() }
    
    // scoring + score modifiers
    
    var totalScore = 0
    var upperScore = 0
    var bonusActive = true
    var hasBonusYahtzee = false // maybe put in other file? or diff name?
}

struct ScoreBox {
    var value = 0
    var isActive = true
}

struct Dice {
    var value = 1
    var isLocked = false
}


// call player v scorecard
// Scorebox v Score
// Dice v Die
