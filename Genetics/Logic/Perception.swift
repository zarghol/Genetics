//
//  Perception.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

struct Perception {
    let creatures: [PerceivedCreature]

    func findPartner() -> PerceivedCreature? {
        let creatures = self.creatures.filter { ($0.age ?? 0) >= Creature.puberty }
        guard !creatures.isEmpty else { return nil }
        guard creatures.count == 1 else { return creatures.first! }

        let maxValue = creatures.reduce(0, { $0 + ($1.attraction ?? 0) })

        var randomValue = Int.random(in: 0...maxValue)
        var currentIndex = 0
        while randomValue > creatures[currentIndex].attraction ?? 0 {
            randomValue -= creatures[currentIndex].attraction ?? 0
            currentIndex += 1
        }

        guard currentIndex < creatures.count else { return nil }
        return creatures[currentIndex]
    }
}
