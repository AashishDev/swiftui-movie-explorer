//
//  NetworkMonitor.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/16/26.
//

import Network
import Observation

@MainActor
@Observable
final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    var isConnected: Bool = false

    private init() {
        start()
    }

    private func start() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            let status = path.status == .satisfied

            Task { @MainActor in
                print("Network changed:", status)
                self.isConnected = status
            }
        }
        monitor.start(queue: queue)
    }
}
