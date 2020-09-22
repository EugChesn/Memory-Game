//
//  Cards.swift
//  GameCard
//
//  Created by Евгений on 22.09.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import Foundation
import UIKit

struct Card {
    var isFaceUp = false
    var isMatched = false
    var emoji: String
    var indexCard: Int

    static var indentifier = 0

    static func indentifierGenerator() -> Int {
        indentifier += 1
        return indentifier
    }

    init(emoji: String) {
        self.indexCard = Self.indentifierGenerator()
        self.emoji = emoji
    }
}
