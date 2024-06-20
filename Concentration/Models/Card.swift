//
//  Card.swift
//  Concentration
//
//  Created by abimael espinal on 6/19/24.
//

import Foundation

struct Card: Identifiable {
    var id = UUID()
    var emoji: String
    var isFaceUp = false
    var isMatched = false
}
