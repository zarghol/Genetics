//
//  MutationType.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

enum MutationType {
    case replacement
    case adding
    case removing
}

extension MutationType: CaseIterable { }

extension MutationType {
    static func random() -> Self {
        let random = Double.random(in: 0 ... 1)

        switch random {
        case 0.85 ..< 0.95:
            return .adding
        case 0.95 ... 1.0:
            return .removing
        default:
            return .replacement
        }
    }

    func apply(on dna: DNA) -> DNA {
        print("\(self)")
        let index = dna.index(dna.startIndex, offsetBy: Int.random(in: 0..<dna.count))
        var newDNA = dna
        switch self {
        case .replacement:
            let newNucleotid = Nucleotid.randomCase()
            newDNA[index] = newNucleotid
        case .adding:
            let newNucleotid = Nucleotid.randomCase()
            newDNA.insert(newNucleotid, at: index)
        case .removing:
            newDNA.remove(at: index)
        }
        print("old DNA : \(dna.debugDescription) | new : \(newDNA.debugDescription)")
        return newDNA
    }
}
