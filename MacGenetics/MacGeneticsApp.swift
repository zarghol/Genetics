//
//  MacGeneticsApp.swift
//  MacGenetics
//
//  Created by Clément Nonn on 07/04/2021.
//  Copyright © 2021 clement.nonn. All rights reserved.
//

import SwiftUI

@main
struct MacGeneticsApp: App {
    @State private var showPopulationView = false

    @StateObject private var environment = EnvironmentManager(environment: Self.createEnvironment())

    var body: some Scene {
        WindowGroup {
            if showPopulationView {
                NavigationView {
                    PopulationView()
                }
                .environmentObject(environment)
            } else {
                MacIntroView(showPopulation: $showPopulationView)
            }
        }
    }

    private static func createEnvironment() -> SimulationEnvironment {
        let firstChar = Characteristics(
            attraction: 200,
            lifeDuration: 10,
            dnaStability: 0.3,
            detection: 0.3,
            fecondation: 0.9,
            resilience: 0.5
        )
        let secondChar = Characteristics(
            attraction: 200,
            lifeDuration: 15,
            dnaStability: 0.3,
            detection: 0.6,
            fecondation: 0.5,
            resilience: 0.5
        )

        let nameGen = try! LocalJsonNameGenerator(fileName: "Names")

        return SimulationEnvironment(
            initialCreatures: [
                Creature(
                    dna: firstChar.encode(),
                    name: nameGen.newName(),
                    birthDate: .init(months: 0, years: 0)
                ),
                Creature(
                    dna: secondChar.encode(),
                    name: nameGen.newName(),
                    birthDate: .init(months: 0, years: 0)
                )
            ],
            nameGenerator: nameGen
        )
    }
}
