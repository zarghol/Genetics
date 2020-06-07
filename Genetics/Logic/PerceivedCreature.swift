//
//  PerceivedCreature.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

struct PerceivedCreature { // optionals because could be not perceived if by the perceiver...
    let age: Int?
    let attraction: Int?
    let isAlive: Bool?
    let name: String
}

extension PerceivedCreature {
    init(creature: Creature) {
        self.age = creature.age
        self.attraction = creature.attraction
        self.isAlive = creature.isAlive
        self.name = creature.name
    }
}
