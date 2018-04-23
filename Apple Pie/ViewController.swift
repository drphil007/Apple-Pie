//
//  ViewController.swift
//  Apple Pie
//
//  Created by Philine Wairata on 19/04/2018.
//  Copyright © 2018 Philine Wairata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // list of words the player can guess
    var listOfWords = ["cat","goldfish","playstation","gamecube",
                       "yasmintea","destiny"]
    
    // allowed incorrect guesses for the player
    let incorrectMovesAllowed = 5
    
    // number of wins
    var totalWins = 0 {
        // allows new round after win
        didSet {
            newRound()
        }
    }
    
    // number of losses
    var totalLosses = 0 {
        // allows new round after loss
        didSet {
            newRound()
        }
    }
    
    // Tree Image used from http://www.sght.nichost.ru/%D0%B8%D1%82%D0%BE%D0%B3%D0%B8-%D0%B0%D0%BA%D1%86%D0%B8%D0%B8-%D0%BF%D0%BE-%D1%81%D0%B1%D0%BE%D1%80%D1%83-%D0%BC%D0%B0%D0%BA%D1%83%D0%BB%D0%B0%D1%82%D1%83%D1%80%D1%8B-%D1%81%D0%BE%D1%85%D1%80/
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    /// disables button playes used
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    /// keeps track of loss, wins and alows player to continue guessing
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
        else {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // after loading view start new round
        newRound()
    }

    var currentGame: Game!
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    /// enables and re-anbles all of the buttons, disables buttons when there are no more words to play with
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining:
                incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }
        else {
            enableLetterButtons(false)
        }
    }
    
    /// updates score and image view
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

