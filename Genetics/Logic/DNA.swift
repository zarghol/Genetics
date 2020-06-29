//
//  DNA.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

struct DNA {
    private var firstStrand: [Nucleotid]
    private var secondStrand: [Nucleotid]

    init(firstStrand: [Nucleotid], secondStrand: [Nucleotid]) {
        let usedFirstStrand: [Nucleotid]
        let usedSecondStrand: [Nucleotid]
        if firstStrand.count > secondStrand.count {
            usedFirstStrand = firstStrand.dropLast(firstStrand.count - secondStrand.count)
            usedSecondStrand = secondStrand
        } else if firstStrand.count < secondStrand.count {
            usedFirstStrand = firstStrand
            usedSecondStrand = secondStrand.dropLast(secondStrand.count - firstStrand.count)
        } else {
            usedFirstStrand = firstStrand
            usedSecondStrand = secondStrand
        }

        self.firstStrand = usedFirstStrand
        self.secondStrand = usedSecondStrand
    }

    var minimalLength: Int {
        return min(firstStrand.count, secondStrand.count)
    }

    mutating func applyMutation(_ mutation: (inout [Nucleotid]) -> Void) {
        let isFirst = Bool.random()
        if isFirst {
            mutation(&secondStrand)
        } else {
            mutation(&secondStrand)
        }
    }

    subscript(_ range: Range<Int>) -> [Nucleotid] {
        get {
            guard !range.isEmpty else { return [] }

            var alleleRange = range
            let dominanceRange = alleleRange.removeFirst()
            let firstEncodedDominance = firstStrand[dominanceRange]
            let secondEncodedDominance = secondStrand[dominanceRange]

            if firstEncodedDominance > secondEncodedDominance {
                return Array(firstStrand[alleleRange])
            } else if firstEncodedDominance > secondEncodedDominance {
                return Array(secondStrand[alleleRange])
            } else {
                return Array((Bool.random() ? firstStrand : secondStrand)[alleleRange])
            }
        }
    }
}

extension DNA: CustomDebugStringConvertible {
    var debugDescription: String {
        let a = [firstStrand.map { $0.rawValue }.joined(), secondStrand.map { $0.rawValue }.joined()].joined(separator: " | ")
        return "🧬 " + a
    }
}

extension DNA {
    enum Error: Swift.Error {
        case strandLength
    }

    static func random(length: Int) -> DNA {
        DNA(
            firstStrand: (0..<length).map { _ in Nucleotid.randomCase() },
            secondStrand: (0..<length).map { _ in Nucleotid.randomCase() }
        )
    }

    init(parent1: DNA, parent2: DNA) {
        let parent1Strand = Bool.random() ? parent1.firstStrand : parent1.secondStrand
        let parent2Strand = Bool.random() ? parent2.firstStrand : parent2.secondStrand

        let oneToFirst = Bool.random()
        self.init(firstStrand: oneToFirst ? parent1Strand : parent2Strand, secondStrand: oneToFirst ? parent2Strand : parent1Strand)
    }
}
