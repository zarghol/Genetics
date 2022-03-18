//
//  macIntroView.swift
//  Genetics
//
//  Created by Clément Nonn on 07/04/2021.
//  Copyright © 2021 clement.nonn. All rights reserved.
//

import SwiftUI

struct MacIntroView: View {
    @Binding var showPopulation: Bool

    var body: some View {
        VStack {
            Text("Bienvenue dans Genetics, une simulation de population évoluant selon des traits similaire à l'ADN. Cet ADN peut muter spontanément, mais un brassage génétique à également lieux lors de la reproduction des individus. Voyons jusqu'ou cette population va !"
            )
            .padding(.vertical)

            List {
                Section(header: Text("Paramètres")) {
                    Text("Aucun paramètre pris en charge pour le moment")
                        .padding()
                        .foregroundColor(.gray)
                }
            }

            Button(
                action: { self.showPopulation = true },
                label: { Text("🚀") }
            )
        }
        .padding()
        .navigationTitle("🧬 Genetics 🧬")
    }

}

struct MacIntroView_Previews: PreviewProvider {
    static var previews: some View {
        MacIntroView(showPopulation: .constant(false))
    }
}
