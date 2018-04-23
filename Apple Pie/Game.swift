//
//  Game.swift
//  Apple Pie
//
//  Created by Philine Wairata on 19/04/2018.
//  Copyright © 2018 Philine Wairata. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]

    /// keeps track of seleected letters, adds it to the collection and updates incorrectMovesRemaining if necesseray
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.characters.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
    
    /// computes version of word that hides the missing letters
    var formattedWord: String {
        var guessedWord = ""
        for letter in word.characters {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            }
            else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
