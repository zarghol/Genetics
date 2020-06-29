//
//  CreatureView.swift
//  Genetics
//
//  Created by Clément Nonn on 29/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import SwiftUI

extension Creature {

}

struct CreatureView: View {
    let creature: Creature

    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text(creature.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text("\(creature.age) ans")
                    .font(.callout)
                    .foregroundColor(Color.gray)
                Spacer()
                Text(creature.isAlive ? "Vivant" : "Mort")
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(creature.isAlive ? .green : .red)
            }.padding()
            Divider()
            VStack(alignment: .leading) {
                Text("Reproduction")
                HStack {
                    Text("Peut faire des enfants ?")
                    Text(creature.canMakeBabies ? "OUI" : "NON")
                        .padding(5)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                }
                HStack {
                    Text("Dernier rapport :")
                    Text("Il y a 10 ans")
                }
            }
            Divider()
        }

    }
}

struct CreatureView_Previews: PreviewProvider {
    static var previews: some View {
        CreatureView(creature: Creature.fake)

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

