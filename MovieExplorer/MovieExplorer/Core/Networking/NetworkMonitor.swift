import Network

actor NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "network.monitor")
    private var currentStatus = false
    
    func start() {
        monitor.pathUpdateHandler = { [weak self] path in
            Task {
                await self?.update(
                    path.status == .satisfied
                )
            }
        }
        monitor.start(queue: queue)
    }
    
    private func update(_ value: Bool) {
        currentStatus = value
    }
    
    func isConnected() -> Bool {
        currentStatus
    }
    
    func stop() {
        monitor.cancel()
    }
}
