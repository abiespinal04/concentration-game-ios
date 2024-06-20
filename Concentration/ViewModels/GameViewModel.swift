//
//  GameViewModel.swift
//  Concentration
//
//  Created by abimael espinal on 6/19/24.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published private var model: ConcentrationGame
 
    init(){
        self.model = ConcentrationGame(emojis: ["😊", "😂", "🥳", "😎", "🤓", "😇", "😜", "🤩", "🥰", "😴"])
    }
    
    var cards: [Card] {
        model.cards
    }
    
    func getScore() -> Int {
        model.score
    }
    
    func getTotalTries() -> Int {
        model.totalTries
    }
    
    func getIsGameOver() -> Bool {
        model.isGameOver()
    }
    
    func choose(card: Card){
        model.choose(card)
        objectWillChange.send()
    }
    
    func newGame(){
        model.resetGame(with: ["😊", "😂", "🥳", "😎", "🤓", "😇", "😜", "🤩", "🥰", "😴"])
        objectWillChange.send()
    }
}
