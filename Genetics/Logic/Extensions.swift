//
//  Extensions.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

extension CaseIterable {
    static func randomCase() -> Self {
        Self.allCases.randomElement()!
    }

    static func randomCase<T: RandomNumberGenerator>(using generator: inout T) -> Self {
        Self.allCases.randomElement(using: &generator)!
    }
}

extension Collection where Element == Nucleotid {
    func convertToInt() -> Int {
        self.enumerated()
            .map {
                let returnedIndex = self.count - 1 - $0
                return $1.intValue * Int(pow(Double(Nucleotid.base), Double(returnedIndex)))
            }
            .reduce(0, +)
    }
}

extension Int {
    func toPercentage() -> Double {
        guard self < 100 else { return 1.0 }
        guard self > 0 else { return 0.0 }

        return Double(self) / 100
    }

    func convertToNucleotids(minimumDigits: Int = 0) -> [Nucleotid] {
        var arr = [Nucleotid]()
        var toDivise = self
        while toDivise >= Nucleotid.base {
            let remainder = toDivise % Nucleotid.base
            arr.insert(Nucleotid(value: remainder)!, at: 0)
            toDivise /= Nucleotid.base
        }
        arr.insert(Nucleotid(value: toDivise)!, at: 0)

        while arr.count < minimumDigits {
            arr.insert(.a, at: 0)
        }
        return arr
    }
}
