//
//  AppDate.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation

struct AppDate {
    var months: Int
    var years: Int

    mutating func addMonths(_ months: Int) {
        let newMonths = self.months + months
        self.years += newMonths / 12
        self.months = newMonths % 12
    }
}

extension AppDate: CustomStringConvertible {
    var description: String {
        "\(months)/\(years)"
    }
}

extension AppDate: Equatable { }

extension AppDate: Comparable {
    static func < (lhs: AppDate, rhs: AppDate) -> Bool {
        if lhs.years < rhs.years {
            return true
        } else if lhs.years > rhs.years {
            return false
        } else {
            return lhs.months < rhs.months
        }
    }
}

extension AppDate {
    func monthsInterval(with now: AppDate) -> Int {
        let date1 = min(now, self)
        let date2 = date1 == now ? self : now
        if date1.years == date2.years {
            return 0
        } else {
            let firstYearMonths = 12 - date1.months
            let currentYearMonths = date2.months

            let yearsBetween = date2.years - date1.years - 1
            return firstYearMonths + currentYearMonths + yearsBetween * 12
        }
    }
}
