//
//  MockMovieRepository.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Testing
@testable import MovieExplorer

final class MockMovieRepository: MovieListRepositoryProtocol {
    var result: Result<[Movie], Error> = .success([])

    func fetchMovies(forceRefresh: Bool) async throws -> [Movie] {
        try result.get()
    }
}

actor MockNetworkMonitor: NetworkMonitoring {
    private var connected: Bool = true
    func start() async {
    }
    func stop() async {
    }
    func isConnected() async -> Bool {
        connected
    }

    func setConnected(_ value: Bool) {
        connected = value
    }
}
