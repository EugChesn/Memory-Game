//
//  ModelGame.swift
//  GameCard
//
//  Created by Евгений on 22.09.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import Foundation

protocol Modeling {
    var numberCards: Int { get }
    var tapCount: String { get set }
    var textCount: String { get }

    func getCard(at index: Int) -> Card
    func stepGame(at index: Int)
}

class ModelGame: Modeling {

    private var cards = [Card]()
    private var countTap = 0
    private var indexOnlyOneFaceUpCard: Int?
    private var emoji = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🦁"]

    private enum Constants {
        static let numberPair = 20
        static let textCount = "Steps: "
    }

    init() {
        for _ in 0 ..< Constants.numberPair {
            guard let randItem = emoji.randomItem() else { return }
            let card = Card(emoji:  randItem.element)
            emoji.remove(at: randItem.index)
            cards += [card, card]
            cards.shuffle()
        }
    }

    var numberCards: Int {
        return cards.count
    }

    func getCard(at index: Int) -> Card {
        return cards[index]
    }

    var textCount: String {
        return Constants.textCount
    }

    var tapCount: String {
        get {
            return Constants.textCount + "\(countTap)"
        }
        set {
            countTap += 1
        }
    }

    func stepGame(at index: Int) {
        guard !cards[index].isMatched else { return }

        if let matchingIndex = indexOnlyOneFaceUpCard, matchingIndex != index {
            if cards[index].indexCard == cards[matchingIndex].indexCard {
                cards[index].isMatched = true
                cards[matchingIndex].isMatched = true
            }
            cards[index].isFaceUp = true
            indexOnlyOneFaceUpCard = nil
        } else {
            for flipDown in cards.indices {
                cards[flipDown].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOnlyOneFaceUpCard = index
        }
    }
}
