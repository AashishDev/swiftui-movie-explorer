//
//  RecentlyViewedUseCase.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

protocol RecentlyViewedUseCaseProtocol {
    func add(movie: MovieDetail) async throws
    func fetch(limit: Int) async throws -> [RecentlyViewedMovie]
    func clearAll() async throws
}

final class RecentlyViewedUseCase:
    RecentlyViewedUseCaseProtocol {

    private let repository:
        RecentlyViewedRepositoryProtocol

    init(repository: RecentlyViewedRepositoryProtocol) {
        self.repository = repository
    }

    func add(movie: MovieDetail) async throws {
        try await repository.add(movie: movie)
    }

    func fetch(limit: Int) async throws -> [RecentlyViewedMovie] {
        try await repository.fetch(limit: limit)
    }
    
    func clearAll() async throws {
        try await repository.clearAll()
    }
}
