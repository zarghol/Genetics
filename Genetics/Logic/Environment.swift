//
//  Environment.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

class Environment {
    var creatures: [Creature]
    private var reproductionAttempts: [(Creature, Creature)] = []
    var year: Int = 0

    init(creatures: [Creature]) {
        self.creatures = creatures
    }

    // perceive not all the environment but only a slice of it... but interact with the real environment based on the slice
    func perception(by creature: Creature) -> Perception {
        let seenCreatures = self.creatures
            .filter { $0.name != creature.name } // assuming unique names
            .map(PerceivedCreature.init)

        return Perception(creatures: seenCreatures)
    }

    func creature(_ creature: Creature, tryToReproduceWith name: String) {
        guard let creature2 = self.creatures.first(where: { $0.name == name }) else { return }
        self.reproductionAttempts.append((creature, creature2))
    }

    func live() {
        year += 1
        print("new year : \(year)")
        creatures.shuffle()
        print("population (\(creatures.count)): \(creatures.map { $0.name })")
        creatures.forEach { $0.live(in: self) }
        creatures = creatures.filter { $0.isAlive }
        resolveReproduction()
    }

    func resolveReproduction() {
        let attempts = reproductionAttempts
            .filter { $0.isAlive && $1.isAlive }

        var reproducing = [Creature]()

        for (wanting, wanted) in attempts {
            if !reproducing.contains(wanting) && !reproducing.contains(wanted) && wanted.isAttracted(for: wanting.attraction) {
                // go
                print("hey ! \(wanted.name) and \(wanting.name) are doing something 🧐")
                reproducing.append(wanting)
                reproducing.append(wanted)
                // do stuff with dna and create new in population
                let newDNA = wanting.cuttedDNA[0] + wanted.cuttedDNA[1]
                let baby = Creature(dna: newDNA, name: UUID().uuidString)
                print("a baby !!! hello \(baby.name) (with DNA : \(baby.dna.debugDescription))")
                self.creatures.append(baby)
            }
        }

        reproductionAttempts.removeAll()
    }

    // potential danger
    // food
}
