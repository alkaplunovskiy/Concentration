//
//  Concentration.swift
//  Concentration
//
//  Created by Alexander Kaplunovskiy on 9/27/19.
//  Copyright © 2019 KAV. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        // if tapped card is unmatched - do this, else - ignore this
        if !cards[index].isMatched {
            // if 1 card already face up, then we have indexOneAndOnlyFaceUpCard
            if let matchIndex = indexOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                // perform flip card at anytime and fail indexOneAndOnlyFaceUpCard, because 2 card are face up
                cards[index].isFaceUp = true
                indexOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    // face down all cards
                    cards[flipDownIndex].isFaceUp = false
                }
                // face up chosen card & give her index to indexOneAndOnlyFaceUpCard because 1 card face up
                cards[index].isFaceUp = true
                indexOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCard: Int) {
        for _ in 1...numberOfPairsOfCard {
            let card = Card()
            cards += [card, card]
        }
        // TODO: shuffle the cards
        shuffleCards(for: cards)
    }
    
    func shuffleCards(for cards: [Card]) {
        for _ in 1...cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let card = self.cards.remove(at: randomIndex)
            self.cards.append(card)
        }
    }
}
