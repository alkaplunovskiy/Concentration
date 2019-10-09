//
//  Concentration.swift
//  Concentration
//
//  Created by Alexander Kaplunovskiy on 9/27/19.
//  Copyright © 2019 KAV. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    private(set) var alreadyFlipedCards = [Card]()
    
    private var indexOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)): chosen index not in the cards")
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 5
                    if watchedCardNumber(for: cards[index]) > 4 {
                        score -= 3
                    }
                }
                cards[index].isFaceUp = true
            } else {
                indexOneAndOnlyFaceUpCard = index
            }
        }
        alreadyFlipedCards.append(cards[index])
    }
    
    private func watchedCardNumber(for card: Card) -> Int {
        let watchCardNumber = alreadyFlipedCards.filter{ $0 == card }
        return watchCardNumber.count
    }
    
    init(numberOfPairsOfCard: Int) {
        assert(numberOfPairsOfCard > 0, "Concentration.init(numberOfPairsOfCard:\(numberOfPairsOfCard)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCard {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
}
