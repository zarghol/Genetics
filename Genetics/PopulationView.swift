//
//  PopulationView.swift
//  Genetics
//
//  Created by Clément Nonn on 08/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import SwiftUI

struct PopulationView: View {
    @EnvironmentObject var environmentManager: EnvironmentManager
    @Environment(\.launchAsStatic) var launchAsStatic
    
    var body: some View {
        List(self.environmentManager.creatures, id: \Creature.name) { creature in
            NavigationLink(
                destination: CreatureView(creature: creature),
                label: {
                    CreatureRow(creature: creature)
                }
            )
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.primaryAction) {
                Button(
                    action: self.environmentManager.playPause,
                    label: {
                        Image(systemName: environmentManager.launched ? "pause.circle.fill" : "play.circle.fill")
                            .imageScale(.large)
                    }
                )
            }
        }
        .navigationTitle(environmentManager.currentDate.description)
//            .onAppear { if !self.launchAsStatic { self.environmentManager.start() } }
    }
}

struct PopulationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopulationView()
        }
        .environment(\.launchAsStatic, true)
        .environmentObject(EnvironmentManager(environment: .mocked))
    }
}


var isViewLaunchedStatically: Bool = false
extension EnvironmentValues {
    var launchAsStatic: Bool {
        get {
            return isViewLaunchedStatically
        }

        set {
            isViewLaunchedStatically = newValue
        }
    }
}
