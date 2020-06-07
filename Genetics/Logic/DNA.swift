//
//  DNA.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

typealias DNA = Array<Nucleotid>

extension DNA {
    var debugDescription: String {
        return self.map { $0.rawValue }.joined()
    }
}
