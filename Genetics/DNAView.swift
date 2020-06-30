//
//  DNAView.swift
//  Genetics
//
//  Created by Clément Nonn on 29/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import SwiftUI

struct DNAView: View {
    var periodCount = 2
    var lineNumberByDemiPeriod: Int = 5
    var lineWidth: CGFloat = 1

    private let segmentCount = 1000 // segment count to draw
    private var lineNumber: Int { (lineNumberByDemiPeriod + 1) * 2 * periodCount }

    private func periodScale(for length: CGFloat) -> CGFloat {
        CGFloat(periodCount) * 2 * .pi / length
    }

    var body: some View {
        GeometryReader(content: { geometry in
            Path { path in
                let centerAxe = geometry.size.width / 2
                let origin = CGPoint(x: centerAxe, y: 0)
                path.move(to: origin)
                let segmentLength = geometry.size.height / CGFloat(segmentCount)

                for segmentNumber in 0..<segmentCount {
                    let y = origin.y + CGFloat(segmentNumber) * segmentLength
                    let x = origin.x + sin(y * periodScale(for:  geometry.size.height)) * centerAxe
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }.stroke(lineWidth: lineWidth)

            Path { path in
                let centerAxe = geometry.size.width / 2
                let origin = CGPoint(x: centerAxe, y: 0)
                path.move(to: origin)
                let segmentLength = geometry.size.height / CGFloat(segmentCount)

                for segmentNumber in 0..<segmentCount {
                    let y = origin.y + CGFloat(segmentNumber) * segmentLength
                    let padding: CGFloat = .pi
                    let x = centerAxe + sin(padding + y * periodScale(for:  geometry.size.height)) * centerAxe
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }.stroke(lineWidth: lineWidth)

            ForEach(0..<lineNumber) { i in
                Path { path in
                    let lineSpacing = geometry.size.height / CGFloat(lineNumber)
                    let y = CGFloat(i) * lineSpacing

                    let centerAxe = geometry.size.width / 2

                    let firstX = centerAxe + sin(y * periodScale(for:  geometry.size.height)) * centerAxe

                    path.move(to: CGPoint(x: firstX, y: y))

                    let padding: CGFloat = .pi
                    let secondX = centerAxe + sin(padding + y * periodScale(for:  geometry.size.height)) * centerAxe

                    path.addLine(to: CGPoint(x: secondX, y: y))
                }.stroke(lineWidth: lineWidth)
            }
        })
    }
}

struct DNAView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DNAView(periodCount: 2, lineNumberByDemiPeriod: 5, lineWidth: 1)
                .previewLayout(.fixed(width: 100, height: 440))

            DNAView(periodCount: 4, lineNumberByDemiPeriod: 3, lineWidth: 2)
                .previewLayout(.fixed(width: 100, height: 440))
        }
    }
}
