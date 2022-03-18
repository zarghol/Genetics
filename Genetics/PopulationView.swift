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
        VStack {
            List(self.environmentManager.result.creatures, id: \Creature.name) { creature in
                NavigationLink(
                    destination: CreatureView(creature: creature),
                    label: {
                        CreatureRow(creature: creature)
                    }
                )
            }
            .listStyle(SidebarListStyle())

            Divider()

            Group {
                if environmentManager.livingPublisher.isRunning {
                    ProgressView("")
                        .progressViewStyle(LinearProgressViewStyle())
                } else {
                    VStack {
                        Text("\(environmentManager.result.creatures.count) creatures")
                        Text("Date : \(environmentManager.result.currentDate.description)")
                    }
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                Button {
                    NSApp.keyWindow?
                        .firstResponder?
                        .tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                } label: {
                    Image(systemName: "sidebar.left")
                }
            }

            ToolbarItem(placement: ToolbarItemPlacement.primaryAction) {
                Button(
                    action: self.environmentManager.playPause,
                    label: {
                        Image(systemName: environmentManager.livingPublisher.isRunning ? "pause.circle.fill" : "play.circle.fill")
                            .imageScale(.large)
                    }
                )
            }
        }
        .navigationTitle(environmentManager.result.currentDate.description)
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
