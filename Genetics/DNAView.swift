//
//  DNAView.swift
//  Genetics
//
//  Created by Clément Nonn on 29/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import SwiftUI

struct DNAView: View {
    let curveNumber = 5
    var lineNumber: Int { curveNumber * 10 }
    var finalAngle: CGFloat { CGFloat(curveNumber) * 360.0 }

    var body: some View {
        GeometryReader(content: { geometry in
            Path { path in
                let origin = CGPoint(x: geometry.size.width / 2, y: 0)
                path.move(to: origin)

                for angle in stride(from: 5.0, through: finalAngle, by: 5.0) {
                    let y = origin.y + CGFloat(angle / finalAngle) * geometry.size.height
                    let x = origin.x - CGFloat(sin(angle/180.0 * .pi)) * geometry.size.width * 0.5
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }.stroke()

            Path { path in
                let x = CGFloat(sin(100/180.0 * .pi)) * geometry.size.width * 0.5
                let origin = CGPoint(x: x, y: 0)
                path.move(to: origin)

                for angle in stride(from: 5.0, through: finalAngle, by: 5.0) {
                    let y = origin.y + CGFloat(angle / finalAngle) * geometry.size.height
                    let x = origin.x - CGFloat(sin((angle + 130)/180.0 * .pi)) * geometry.size.width * 0.5
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }.stroke()

            ForEach(0..<lineNumber) { i in
                Path { path in
                    let lineSpacing = geometry.size.height / CGFloat(lineNumber)
                    let y = CGFloat(i) * lineSpacing

                    let firstAngle = 2 * finalAngle * y / geometry.size.height

                    let firstX = (geometry.size.width * 0.5) - CGFloat(sin(firstAngle/180.0 * .pi)) * geometry.size.width * 0.5

                    path.move(to: CGPoint(x: firstX, y: y))

                    let secondX = (geometry.size.width * 0.5) - CGFloat(sin((firstAngle + 130)/180.0 * .pi)) * geometry.size.width * 0.5

                    path.addLine(to: CGPoint(x: secondX, y: y))
                }.stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            }
        })
    }
}

struct DNAView_Previews: PreviewProvider {
    static var previews: some View {
        DNAView()
            .previewLayout(.fixed(width: 100, height: 500))
    }
}
