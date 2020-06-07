//
//  Environment.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

class Environment {
    let nameGenerator: NameGenerator
    var creatures: [Creature]
    private var reproductionAttempts: [(Creature, Creature)] = []
    private(set) var now: AppDate = .init(months: 0, years: 0)

    init(initialCreatures: [Creature], nameGenerator: NameGenerator) {
        self.creatures = initialCreatures
        self.nameGenerator = nameGenerator
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
        now.addMonths(1)
        if now.months == 0 {
            print("happy new year !! \(now.years) 🎉")
        } else {
            print("a new month come (\(now.months))")
        }

        creatures.shuffle()
        print("population (\(creatures.count)): \(creatures.map { $0.name })")
        creatures.forEach { $0.live(in: self) }
        creatures = creatures.filter { $0.isAlive }
        resolveReproduction()
    }

    func newName() -> String {
        let existingNames = creatures.map { $0.name}
        var name = ""
        repeat {
            name = nameGenerator.newName()
        } while existingNames.contains(name)

        return name
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

                let newDNA = wanting.reproduce(at: now)[0] + wanted.reproduce(at: now)[1]
                let baby = Creature(dna: newDNA, name: newName(), birthDate: now)
                print("a baby !!! hello \(baby.name) (with DNA : \(baby.dna.debugDescription))")
                self.creatures.append(baby)
            }
        }

        reproductionAttempts.removeAll()
    }

    // potential danger
    // food
}
