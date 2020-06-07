//
//  ContentView.swift
//  Genetics
//
//  Created by Clément Nonn on 07/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    func live() {
        let aliceChar = Characteristics(attraction: 200, lifeDuration: 10, dnaStability: 0.7, detection: 0.3, fecondation: 0.9, resilience: 0.5)
        let bobChar = Characteristics(attraction: 200, lifeDuration: 15, dnaStability: 0.6, detection: 0.6, fecondation: 0.5, resilience: 0.7)

        let env = Environment(creatures: [
            Creature(dna: aliceChar.encode(), name: "Alice"),
            Creature(dna: bobChar.encode(), name: "Bob")
        ])

        while true {
            env.live()
        }
    }
    var body: some View {
        Text("Hello, World!")
            .onAppear(perform: live)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
