//
//  GeneticsTests.swift
//  GeneticsTests
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

@testable import Genetics
import XCTest

class GeneticsTests: XCTestCase {
    func testDNAConvertToInt() {
        let a: [Nucleotid] = [.a, .t, .g, .c]
        let intValue = a.convertToInt()

        XCTAssertEqual(intValue, 27)

        let b: [Nucleotid] = [.c, .a]
        let intValueB = b.convertToInt()

        XCTAssertEqual(intValueB, 12)

        let c: [Nucleotid] = [.a, .a, .a, .a, .c]
        let intValueC = c.convertToInt()

        XCTAssertEqual(intValueC, 3)
    }

    func testToPercentage() {
        let val1 = 80
        let val2 = 23
        let val3 = 2

        XCTAssertEqual(val1.toPercentage(), 0.8)
        XCTAssertEqual(val2.toPercentage(), 0.23)
        XCTAssertEqual(val3.toPercentage(), 0.02)
    }

    func testIntConvertToDNA() {
        let a = 27

        let dnaA = a.convertToNucleotids()
        XCTAssertEqual(dnaA, [.t, .g, .c])

        let dnaAprime = a.convertToNucleotids(minimumDigits: 4)
        XCTAssertEqual(dnaAprime, [.a, .t, .g, .c])

        let b = 12
        let dnaB = b.convertToNucleotids()

        XCTAssertEqual(dnaB, [.c, .a])

        let c = 512
        let dnaC = c.convertToNucleotids()

        XCTAssertEqual(dnaC, [.g, .a, .a, .a, .a])
    }
}
