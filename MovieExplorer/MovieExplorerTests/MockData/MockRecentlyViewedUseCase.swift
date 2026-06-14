//
//  MockRecentlyViewedUseCase.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Testing
@testable import MovieExplorer
import Foundation

final class MockRecentlyViewedUseCase: RecentlyViewedUseCaseProtocol {

    var items: [RecentlyViewedMovie] = []
    var shouldThrow = false

    func fetch(limit: Int) async throws -> [RecentlyViewedMovie] {
        if shouldThrow { throw URLError(.badServerResponse) }
        return items
    }

    func clearAll() async throws {
        items = []
    }

    func add(movie: MovieDetail) async throws {}
}
