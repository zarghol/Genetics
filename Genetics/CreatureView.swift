//
//  CreatureView.swift
//  Genetics
//
//  Created by Clément Nonn on 29/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import SwiftUI

struct CreatureStatView: View {
    let statName: String
    let stats: AlleleCoupleDescription

    var body: some View {
        VStack(alignment: .leading) {
            Text(statName)
                .font(.headline)
            HStack {
                Text("A \(stats.first.valueDescription)")
                Text("Dom. \(stats.first.dominance)")
            }
            HStack {
                Text("B \(stats.second.valueDescription)")
                Text("Dom. \(stats.second.dominance)")
            }
        }
    }
}

struct CreatureView: View {
    let creature: Creature

    private let stats: RawDNAReader?

    init(creature: Creature) {
        self.creature = creature
        self.stats = try? RawDNAReader(dna: creature.dna)
    }

    var header: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("\(creature.age) ans")
                .font(.callout)
                .foregroundColor(Color.gray)
            Spacer()
            Text(creature.isAlive ? "Vivant" : "Mort")
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(creature.isAlive ? .green : .red)
        }
    }

    var body: some View {
        List {
            Section(header: Text("Reproduction").bold()) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Peut faire des enfants ?")
                        Text(creature.canMakeBabies ? "OUI" : "NON")
                            .padding(5)
                            .border(Color.black, width: 1)
                    }
                    HStack {
                        Text("Dernier rapport :")
                        Text("Il y a 10 ans")
                    }
                }.padding(.vertical, 5)
            }

            Section(header: Text("Détails").bold()) {
                HStack(alignment: .top) {
                    DNAView(periodCount: 3, lineNumberByDemiPeriod: 5, lineWidth: 1)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                    VStack(alignment: .leading, spacing: 10) {
                        if let stats = stats {
                            CreatureStatView(
                                statName: "Attraction",
                                stats: stats.attraction
                            )
                            CreatureStatView(
                                statName: "Durée de vie",
                                stats: stats.lifeDuration
                            )
                            CreatureStatView(
                                statName: "Stabilité ADN",
                                stats: stats.dnaStability
                            )
                            CreatureStatView(
                                statName: "Détection",
                                stats: stats.detection
                            )
                            CreatureStatView(
                                statName: "Fécondation",
                                stats: stats.fecondation
                            )
                            CreatureStatView(
                                statName: "Résilience",
                                stats: stats.resilience
                            )

                        } else {
                            Text("L'ADN de cette créature est corrompue et ne peut être lu")
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: header)
        .navigationTitle(creature.name)
    }
}

struct CreatureView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreatureView(creature: Creature.fake)
        }
    }
}


extension Creature {
    static var fake: Creature {
        let firstChar = Characteristics(
            attraction: 200,
            lifeDuration: 10,
            dnaStability: 0.3,
            detection: 0.3,
            fecondation: 0.9,
            resilience: 0.5
        )

        return Creature(dna: firstChar.encode(), name: "Toto", birthDate: .init(months: 0, years: 0))
    }
}

