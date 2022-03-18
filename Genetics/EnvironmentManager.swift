//
//  EnvironmentManager.swift
//  Genetics
//
//  Created by Clément Nonn on 14/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation
import Combine

extension EnvironmentManager {
    struct SimulationIterationResult {
        let currentDate: AppDate
        let creatures: [Creature]
    }
}

final class EnvironmentManager: ObservableObject {
    private let loopQueue = DispatchQueue(label: "com.genetics.environmentLiving.queue", qos: .background)

    let livingPublisher: ThrowableLoopPublisher<SimulationIterationResult>
    @Published var result: SimulationIterationResult

    var environmentCancellable: AnyCancellable?

    init(environment: SimulationEnvironment) {
        result = SimulationIterationResult(
            currentDate: environment.now,
            creatures: environment.creatures
        )
        
        self.livingPublisher = ThrowableLoopPublisher {
            environment.live()

            return SimulationIterationResult(
                currentDate: environment.now,
                creatures: environment.creatures
            )
        }

        environmentCancellable = self.livingPublisher
            .subscribe(on: loopQueue)
            .receive(on: DispatchQueue.main)
            .print()
            .sink(receiveCompletion: { _ in }) { result in
                self.result = result
            }
    }

    func playPause() {
        print("😱 try to toggle !!!")
        self.objectWillChange.send()
        if livingPublisher.isRunning {
            livingPublisher.stop()
        } else {
            livingPublisher.start()
        }
    }
}
