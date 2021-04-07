//
//  EnvironmentManager.swift
//  Genetics
//
//  Created by Clément Nonn on 14/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation
import Combine

final class EnvironmentManager: ObservableObject {
    let environment: SimulationEnvironment

    private let loopQueue = DispatchQueue(label: "com.genetics.environmentLiving.queue", qos: .background)
    private let accessQueue = DispatchQueue(label: "com.genetics.environmentLiving.access.queue", qos: .background)

    @Published var launched: Bool = false
    @Published var currentDate: AppDate
    @Published var creatures: [Creature]

    init(environment: SimulationEnvironment) {
        self.environment = environment
        self.currentDate = self.environment.now
        self.creatures = self.environment.creatures
    }

    func playPause() {
        print("😱 try to toggle !!!")
        if accessQueue.sync(execute: { return self.launched }) {
            self.stop()
        } else {
            self.start()
        }
    }

    func start() {
        let currentLaunched = accessQueue.sync(execute: { return self.launched })
        guard !currentLaunched else { return }

        accessQueue.sync {
            self.launched = true
        }

        Future<Void, Never> { promise in
            self.loopQueue.async {
                while true {
                    let loopedLaunched = self.accessQueue.sync(execute: { return self.launched })
                    if !loopedLaunched { break }
                    self.loop()
                }
            }
        }


    }

    func stop() {
        accessQueue.sync {
            self.launched = false
        }
    }

    func loop() {
        environment.live()

        DispatchQueue.main.async {
            self.currentDate = self.environment.now
            self.creatures = self.environment.creatures

            if self.checkNeedsToEnd() {
                self.accessQueue.sync {
                    self.launched = false
                }
            }
        }
    }

    private func checkNeedsToEnd() -> Bool {
        return environment.creatures.isEmpty || environment.now.years > 30
    }
}
