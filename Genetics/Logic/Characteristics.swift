//
//  Characteristics.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

struct Characteristics {
    let attraction: Int // value
    let lifeDuration: Int // additional cycle
    let dnaStability: Double // percentage
    let detection: Double // percentage
    let fecondation: Double // percentage
    let resilience: Double // percentage
}

extension Characteristics {
    enum Error: Swift.Error {
        case truncatedDNA(Int)
    }

    init(dna: DNA) throws {
        guard dna.count >= 19 else { throw Error.truncatedDNA(dna.count) }

        self.attraction = dna[0...3].convertToInt()
        self.lifeDuration = dna[4...6].convertToInt() - 20
        self.dnaStability = (dna[7...9].convertToInt() - 30).toPercentage()
        self.detection = dna[10...13].convertToInt().toPercentage()
        self.fecondation = dna[14...15].convertToInt().toPercentage()
        self.resilience = dna[16...20].convertToInt().toPercentage()
    }

    func encode() -> DNA {
        let att = self.attraction.convertToNucleotids(minimumDigits: 3)
        let lif = (self.lifeDuration + 20).convertToNucleotids(minimumDigits: 3)
        let sta = Int(self.dnaStability * 100 + 30).convertToNucleotids(minimumDigits: 3)
        let det = Int(self.detection * 100).convertToNucleotids(minimumDigits: 4)
        let fec = Int(self.fecondation * 100).convertToNucleotids(minimumDigits: 2)
        let res = Int(self.resilience * 100).convertToNucleotids(minimumDigits: 4)
        return att + lif + sta + det + fec + res
    }
}

// a. which caracteristics do we want to code in DNA ?
// detection, durée de vie, resilience de mutation, stabilite, attirance pour reproduction, chance de fecondation
// detection : 0 - 99 : pourcentage de detection de danger durant itération (danger aléatoire peut survenir pour tuer la créature) : 4 digits
// durée de vie : total = base de l'espece + duree de vie | -20 - +20 : 3 digits
// resilience : 0 - 99 : pourcentage de chance de résister à une mutation quand elle arrive : 4 digits
// stabilité : -30 - 30 : pourcentage additionnel au pourcentage de base de chance d'avoir une mutation : 3 digits
// attirance : facteur d'attraction des autres individus : 4 digits
// fecondation : 0 - 15 (+ 80%) : chance qu'une reproduction mene à un nouvel individu : 2 digits

// Definition de l'ordre => [attirance, duree de vie, stabilité, detection, fecondation, resilience]
// [55522244411116663333] -> 20 digits
