//
//  Nucleotid.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

enum Nucleotid: String {
    case a = "A" // Adénine
    case t = "T" // Thymine
    case g = "G" // Guanine
    case c = "C" // Cytosine

    var intValue: Int {
        switch self {
        case .a:
            return 0
        case .t:
            return 1
        case .g:
            return 2
        case .c:
            return 3
        }
    }

    static var base: Int { 4 }
}

extension Nucleotid: CaseIterable { }

extension Nucleotid {
    init?(value: Int) {
        guard let val = Self.allCases.first(where: { $0.intValue == value }) else { return nil }
        self = val
    }
}
