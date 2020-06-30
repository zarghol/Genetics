//
//  RawDNAReader.swift
//  Genetics
//
//  Created by Clément Nonn on 30/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

struct AlleleDescription {
    let valueDescription: String
    let dominance: Int
}

struct AlleleCoupleDescription {
    let first: AlleleDescription
    let second: AlleleDescription
}

struct RawDNAReader {
    let attraction: AlleleCoupleDescription
    let lifeDuration: AlleleCoupleDescription
    let dnaStability: AlleleCoupleDescription
    let detection: AlleleCoupleDescription
    let fecondation: AlleleCoupleDescription
    let resilience: AlleleCoupleDescription
}

extension AlleleDescription {
    init(strand: [Nucleotid], range: Range<Int>, valueDescriptionBuilder: (ArraySlice<Nucleotid>) -> String) {
        var valueIndex = range
        let dominanceIndex = valueIndex.removeFirst()
        self.init(
            valueDescription: valueDescriptionBuilder(strand[valueIndex]),
            dominance: strand[dominanceIndex].intValue
        )
    }
}

extension AlleleCoupleDescription {
    init(dna: DNA, range: Range<Int>, valueDescriptionBuilder: (ArraySlice<Nucleotid>) -> String) {
        self.init(
            first: .init(
                strand: dna.firstStrand,
                range: range,
                valueDescriptionBuilder: valueDescriptionBuilder
            ),
            second: .init(
                strand: dna.secondStrand,
                range: range,
                valueDescriptionBuilder: valueDescriptionBuilder
            )
        )
    }
}
extension RawDNAReader {
    init(dna: DNA) throws {
        guard dna.minimalLength >= 26 else { throw Characteristics.Error.truncatedDNA(dna.minimalLength) }

        self.attraction = AlleleCoupleDescription(dna: dna, range: 0..<5) { $0.convertToInt().description }
        self.lifeDuration = AlleleCoupleDescription(dna: dna, range: 5..<9) { ($0.convertToInt() - 20).description }
        self.dnaStability = AlleleCoupleDescription(dna: dna, range: 9..<13) { "\(($0.convertToInt() - 30).toPercentage() * 100) %" }
        self.detection = AlleleCoupleDescription(dna: dna, range: 13..<18) { "\($0.convertToInt().toPercentage() * 100) %" }
        self.fecondation = AlleleCoupleDescription(dna: dna, range: 18..<21) { "\($0.convertToInt().toPercentage() * 100) %" }
        self.resilience = AlleleCoupleDescription(dna: dna, range: 21..<26) { "\(($0.convertToInt() / 511).toPercentage() * 100) %" }
    }
}
