//
//  Names.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

protocol NameGenerator {
    func newName() -> String
}

fileprivate struct Names: Decodable {
    let names: [String]
}

final class LocalJsonNameGenerator: NameGenerator {
    private let names: [String]

    init(fileName: String) throws {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw Error.badFileName(fileName)
        }

        let data = try Data(contentsOf: url)
        let names = try JSONDecoder().decode(Names.self, from: data).names
        guard !names.isEmpty else { throw Error.fileListEmpty }

        self.names = names
    }

    func newName() -> String {
        names.randomElement()!
    }
}

extension LocalJsonNameGenerator {
    enum Error: Swift.Error {
        case badFileName(String)
        case fileListEmpty
    }
}
