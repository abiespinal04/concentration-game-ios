//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by abimael espinal on 6/19/24.
//

import Foundation


class ConcentrationGame {
    private(set) var cards: [Card] = []
    private var indexOfFaceUpCard: Int?
    private(set) var score: Int = 0
    private var alreadyShownCards: [Card] = []
    private (set) var totalTries = 10
    
    init(emojis: [String]){
        resetGame(with: emojis)
    }
    
    func choose(_ card: Card){
        if totalTries == 0 {
            return
        }
        
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfFaceUpCard {
                // Check if the potential match card is already in the shown cards
                if !alreadyShownCards.contains(where: { $0.id == cards[chosenIndex].id }) {
                              alreadyShownCards.append(cards[chosenIndex])
                } else if cards[chosenIndex].emoji == cards[potentialMatchIndex].emoji {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 10
                } else {
                    totalTries -= 1
                }
                
                    
                indexOfFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                // Add the chosen card to alreadyShownCards if it didn't match
                if !alreadyShownCards.contains(where: { $0.id == cards[chosenIndex].id }) {
                                  alreadyShownCards.append(cards[chosenIndex])
                }
                
                indexOfFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    func isGameOver() -> Bool {
        return totalTries == 0
    }
    
    func resetGame(with emojis: [String]){
        cards = []
        for emoji in emojis {
            cards.append(Card(emoji: emoji))
            cards.append(Card(emoji: emoji))
        }
        cards.shuffle()
         
        indexOfFaceUpCard = nil
        
        score = 0
        totalTries = 10
    }
    
}
