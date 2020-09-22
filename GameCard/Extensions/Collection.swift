//
//  Collection.swift
//  GameCard
//
//  Created by Евгений on 22.09.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import Foundation

extension Array {
    func randomItem() -> (index: Int, element: Element)? {
        guard !isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return (index, self[index])
    }
}
