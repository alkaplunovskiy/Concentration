//
//  ViewController.swift
//  Concentration
//
//  Created by Alexander Kaplunovskiy on 9/25/19.
//  Copyright © 2019 KAV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let emojiChoices = [
        "Halloween": "👻🎃😱💀🍭👿",
        "Animals": "🐶🐱🐭🐧🐔🐷",
        "Sports": "⚽️🎾🏓🎱🥊🏉",
        "Faces": "😀🤪😅😎🥶😭",
        "Transport": "🚘🚁🚑✈️🚓🚋",
        "Flags": "🇨🇦🇧🇷🇬🇪🇺🇦🇷🇺🇪🇸"
    ]
    
    private(set) var randomEmojiTheme: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomEmojiTheme = randomTheme(from: emojiChoices)
    }
    
    private lazy var game = Concentration(numberOfPairsOfCard: numberOfPairsOfCard)
           
    var numberOfPairsOfCard: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            flipCountLabel.attributedText = attributedString(for: "Flips: \(game.flipCount)")
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private var scoreLabel: UILabel! {
        didSet {
            scoreLabel.attributedText = attributedString(for: "Score: \(game.score)")
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        } else {
            print("Chosen card is not in the array")
        }
    }
    
    private func attributedString(for string: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        return NSAttributedString(string: string, attributes: attributes)
    }
    
    private func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle(nil, for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

    
    
    private(set) var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, randomEmojiTheme.count > 0 {
            let randomStringIndex = randomEmojiTheme.index(randomEmojiTheme.startIndex, offsetBy: randomEmojiTheme.count.arc4random)
            emoji[card] = String(randomEmojiTheme.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    private func randomTheme(from dictionary: [String: String]) -> String {
        let emojiChoicesKeys = Array(dictionary.keys)
        let randomKeysNumber = emojiChoicesKeys.count.arc4random
        let randomEmojiTheme = emojiChoicesKeys[randomKeysNumber]
        return dictionary[randomEmojiTheme]!
    }
    
    @IBAction private func newGameTapped(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCard: numberOfPairsOfCard)
        randomEmojiTheme = randomTheme(from: emojiChoices)
        emoji = [:]
        updateViewFromModel()
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
