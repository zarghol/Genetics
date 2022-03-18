//
//  LoopPublisher.swift
//  Genetics
//
//  Created by Clément Nonn on 03/07/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import Foundation
import Combine

@propertyWrapper
struct Synchronized<WrappedType> {

    let queue: DispatchQueue

    var projectedValue: WrappedType

    var wrappedValue: WrappedType {
        get {
            queue.sync(execute: { projectedValue })
        }

        set {
            queue.sync {
                projectedValue = newValue
            }
        }
    }

    init(wrappedValue: WrappedType, queue: DispatchQueue) {
        self.queue = queue
        self.projectedValue = wrappedValue
    }
}

fileprivate var shouldContinueQueue = DispatchQueue(label: "com.genetics.loop.shouldContinueAccess", qos: .background)

final class ThrowableLoopPublisher<Output>: Publisher {
    typealias Failure = Error

    private let loop: () throws -> Output
    private var subscriptions: [Subscriptions.ThrowableLoopSubscription<Output>]

    private var queue = DispatchQueue(label: "com.genetics.loop.publisher", qos: .background)


    init(_ loop: @escaping () throws -> Output) {
        self.loop = loop
        self.subscriptions = []
    }

    func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Error, Output == S.Input {
        let subscription = Subscriptions.ThrowableLoopSubscription(
            publisher: self,
            subscriber: AnySubscriber<Output, Failure>(subscriber)
        )
        subscriptions.append(subscription)
        subscriber.receive(subscription: subscription)
    }

    fileprivate func remove(subscription: Subscriptions.ThrowableLoopSubscription<Output>) {
        subscriptions.removeAll { subscription.id == $0.id }
    }

    @Synchronized(queue: shouldContinueQueue) private(set) var isRunning = false

    func start() {
        isRunning = true

        queue.async { [weak self] in
            self?.cycle()
        }
    }

    func stop() {
        isRunning = false
    }

    private func cycle() {
        do {
            while isRunning {
                try iterate()
            }
        } catch {
            self.subscriptions.forEach {
                $0.subscriber.receive(completion: .failure(error))
            }
        }
    }

    private func iterate() throws {
        let result = try loop()

        self.subscriptions.forEach {
            $0.sendValue(result)
        }
    }
}

extension Subscriptions {
    fileprivate final class ThrowableLoopSubscription<Input>: Subscription {
        unowned var publisher: ThrowableLoopPublisher<Input>
        var subscriber: AnySubscriber<Input, Error>

        var id: UUID

        var demand: Subscribers.Demand = .none

        var canReceiveValue: Bool { demand > 0 }

        init(publisher: ThrowableLoopPublisher<Input>, subscriber: AnySubscriber<Input, Error>) {
            self.publisher = publisher
            self.subscriber = subscriber
            self.id = UUID()
        }

        func cancel() {
            publisher.remove(subscription: self)
        }

        func request(_ demand: Subscribers.Demand) {
            self.demand = demand
        }

        func sendValue(_ value: Input) {
            guard canReceiveValue else {
                subscriber.receive(completion: .finished)
                return
            }

            demand = subscriber.receive(value)

            if !canReceiveValue {
                subscriber.receive(completion: .finished)
            }
        }
    }
}
