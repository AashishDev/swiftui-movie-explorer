//
//  MockDetailRecentlyViewedUseCase.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/14/26.
//

import Testing
@testable import MovieExplorer

final class MockDetailRecentlyViewedUseCase: RecentlyViewedUseCaseProtocol {

    var addedMovie: MovieDetail?

    func add(movie: MovieDetail) async throws {
        addedMovie = movie
    }

    func fetch(limit: Int) async throws -> [RecentlyViewedMovie] {
        return []
    }

    func clearAll() async throws {}
}
