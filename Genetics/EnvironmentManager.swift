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

    @Published var launched: Bool = false
    @Published var currentDate: AppDate
    @Published var creatures: [Creature]

    init(environment: SimulationEnvironment) {
        self.environment = environment
        self.currentDate = self.environment.now
        self.creatures = self.environment.creatures
    }

    func playPause() {
        if launched {
            self.stop()
        } else {
            self.start()
        }
    }

    func start() {
        guard !launched else { return }

        launched = true

        loopQueue.async {
            while self.launched {
                self.loop()
            }
        }
    }

    func stop() {
        launched = false
    }

    func loop() {
        environment.live()
        if self.checkNeedsToEnd() {
            self.launched = false
        }
        DispatchQueue.main.async {
            self.currentDate = self.environment.now
            self.creatures = self.environment.creatures
        }
    }

    private func checkNeedsToEnd() -> Bool {
        return environment.creatures.isEmpty
    }
}
