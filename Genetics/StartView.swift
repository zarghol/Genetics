//
//  StartView.swift
//  Genetics
//
//  Created by Clément Nonn on 08/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    Section {
                        Text("Bienvenue dans Genetics, une simulation de population évoluant selon des traits similaire à l'ADN. Cet ADN peut muter spontanément, mais un brassage génétique à également lieux lors de la reproduction des individus. Voyons jusqu'ou cette population va !")
                            .padding(.vertical)
                    }

                    Section(header: Text("Paramètres")) {
                        Text("Aucun paramètre pris en charge pour le moment").padding().foregroundColor(.gray)
//                        TextField("Test", text: .constant(""))
                    }
                }.listStyle(GroupedListStyle())

                NavigationLink(
                    destination: PopulationView()
                        .environmentObject(EnvironmentManager(
                        environment: self.createEnvironment())),
                    label: {
                        Text("🚀")
                            .font(.title)
                            .padding()
                            .background(Color(.displayP3, white: 1.0, opacity: 1.0))
                    }
                ).cornerRadius(30)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }.navigationBarTitle("🧬 Genetics 🧬")
        }
    }

    private func createEnvironment() -> SimulationEnvironment {
        let firstChar = Characteristics(attraction: 200, lifeDuration: 10, dnaStability: 0.3, detection: 0.3, fecondation: 0.9, resilience: 0.5)
        let secondChar = Characteristics(attraction: 200, lifeDuration: 15, dnaStability: 0.3, detection: 0.6, fecondation: 0.5, resilience: 0.5)

        let nameGen = try! LocalJsonNameGenerator(fileName: "Names")

        return SimulationEnvironment(initialCreatures: [
            Creature(dna: firstChar.encode(), name: nameGen.newName(), birthDate: .init(months: 0, years: 0)),
            Creature(dna: secondChar.encode(), name: nameGen.newName(), birthDate: .init(months: 0, years: 0))
        ], nameGenerator: nameGen)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
