//
//  Creature.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

class Creature {
    var dna: DNA

    var age: Int = 0 // number of iteration alive
    var attraction: Int = 0 // attraction of the creature
    var isAlive: Bool = true
    var perception: Perception? = nil
    var canMakeBabies: Bool = false
    var lastReproducing: AppDate

    let name: String

    let birthDate: AppDate

    static let puberty = 15 // number of iteration without reproduction enabled
    static let baseLifeTime = 80 // base number of iteration before dying

    init(dna: DNA, name: String, birthDate: AppDate) {
        self.dna = dna
        self.name = name
        self.birthDate = birthDate
        lastReproducing = birthDate
    }

    func live(in environment: Environment) {
        print("live of \(name)")
        guard isAlive else { return }

        guard let characteristics = try? Characteristics(dna: self.dna) else {
            print("die of mutation 🦠 with DNA : \(dna.debugDescription)")
            isAlive = false
            return
        }

        let ageThreshold = Self.baseLifeTime + characteristics.lifeDuration
        if age > ageThreshold {
            print("die of age 👴 (\(age)) (with DNA : \(dna.debugDescription))")
            isAlive = false
            return
        }

        self.age = environment.now.monthsInterval(with: birthDate) / 12
        self.canMakeBabies = age >= Self.puberty && lastReproducing.monthsInterval(with: environment.now) > 9
        self.attraction = characteristics.attraction
        self.updatePerception(of: environment)

        self.tryMutate(with: characteristics)
        self.tryReproduce(in: environment)
        // danger ?

        age += 1
        print("see ya")
    }

    static func willMutate(basedOnAge age: Int, andCharacteristics characteristics: Characteristics) -> Bool {
        let basePercentage = Int(Double(age) * 0.875 + 15).toPercentage()
        let firstChance = basePercentage + characteristics.dnaStability

        let rand = Double.random(in: 0 ... 1)

        if rand <= firstChance {
            let rand2 = Double.random(in: 0 ... 1)
            return rand2 > characteristics.resilience
        } else { return false }
    }

    func updatePerception(of environment: Environment) {
        self.perception = environment.perception(by: self)
    }

    func tryMutate(with characteristics: Characteristics) {
        guard Self.willMutate(basedOnAge: self.age, andCharacteristics: characteristics) else {
            return
        }

        print("mutation happen :")
        self.dna = MutationType
            .random()
            .apply(on: self.dna)
    }

    static func willTryReproduce(basedOnAge age: Int) -> Bool {
        let age = Double(age)
        let chance = Int(0.9 * age * cos(age/10) - age + 80).toPercentage()
        return Double.random(in: 0 ... 1) <= chance
    }

    func tryReproduce(in environment: Environment) {
        guard self.canMakeBabies else { return }
        guard Self.willTryReproduce(basedOnAge: self.age) else { return }
        guard let perception = self.perception else { return }

        guard let partner = perception.findPartner() else { return }
        print("try to reproduce with \(partner.name)")
        environment.creature(self, tryToReproduceWith: partner.name)
    }

    func isAttracted(for attractionScore: Int) -> Bool {
        if self.attraction < attractionScore { return true }
        return Int.random(in: 0...255) < attractionScore
    }

    func reproduce(at time: AppDate) -> [DNA] {
        lastReproducing = time

        let cutIndex = dna.count / 2
        return [DNA(dna[0..<cutIndex]), DNA(dna[cutIndex..<dna.count])]
    }
}

extension Creature: Equatable {
    static func ==(left: Creature, right: Creature) -> Bool {
        return left.name == right.name
    }
}
