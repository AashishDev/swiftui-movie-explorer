//
//  NetworkState.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/16/26.
//
import Observation

@Observable
@MainActor
final class NetworkState {
    let monitor: NetworkMonitoring
    private var task: Task<Void, Never>?
    private(set) var isConnected: Bool = false

    init(monitor: NetworkMonitoring) {
        self.monitor = monitor
        
        task = Task { [weak self] in
            guard let self else { return }

               await monitor.start()
               while !Task.isCancelled {
                   let status = await monitor.isConnected()
                   self.isConnected = status
                   try? await Task.sleep(for: .seconds(1))
               }
           }
    }
    
    func stop() {
        task?.cancel()
        Task {
            await monitor.stop()
        }
    }
}
