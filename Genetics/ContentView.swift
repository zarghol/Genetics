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
        let firstChar = Characteristics(attraction: 200, lifeDuration: 10, dnaStability: 0.3, detection: 0.3, fecondation: 0.9, resilience: 0.5)
        let secondChar = Characteristics(attraction: 200, lifeDuration: 15, dnaStability: 0.3, detection: 0.6, fecondation: 0.5, resilience: 0.5)

        let nameGen = try! LocalJsonNameGenerator(fileName: "Names")

        let env = SimulationEnvironment(initialCreatures: [
            Creature(dna: firstChar.encode(), name: nameGen.newName(), birthDate: .init(months: 0, years: 0)),
            Creature(dna: secondChar.encode(), name: nameGen.newName(), birthDate: .init(months: 0, years: 0))
        ], nameGenerator: nameGen)

//        while true {
//            env.live()
//        }
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
