//
//  ViewController.swift
//  Concentration
//
//  Created by Alexander Kaplunovskiy on 9/25/19.
//  Copyright © 2019 KAV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    var emojiChoices = ["👻", "🎃", "😱", "👻", "🎃", "😱"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            flipCard(withEmoji: emojiChoices[cardIndex], on: sender)
        } else {
            print("Chosen card is not in the array")
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle(nil, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
}

