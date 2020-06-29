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

        var newDNA = dna

        newDNA.applyMutation { strand in
            let index = Int.random(in: 0..<strand.count)
            switch self {
            case .replacement:
                let newNucleotid = Nucleotid.randomCase()
                strand[index] = newNucleotid
            case .adding:
                let newNucleotid = Nucleotid.randomCase()
                strand.insert(newNucleotid, at: index)
            case .removing:
                strand.remove(at: index)
            }
        }
        print("old DNA : \(dna.debugDescription) | new : \(newDNA.debugDescription)")
        return newDNA
    }
}
