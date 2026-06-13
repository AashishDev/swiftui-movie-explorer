//
//  RecentlyViewedRepository.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation

protocol RecentlyViewedRepositoryProtocol {
    func add(movie: MovieDetail) async throws
    func fetch(limit: Int) async throws -> [RecentlyViewedMovie]
    func clearAll() async throws
}

final class RecentlyViewedRepository:
    RecentlyViewedRepositoryProtocol {

    private let local:
    RecentlyViewedLocalDataSourceProtocol

    init(local: RecentlyViewedLocalDataSourceProtocol) {
        self.local = local
    }

    func add(movie: MovieDetail) async throws {
        try local.add(movie: movie)
    }

    func fetch(limit: Int) async throws -> [RecentlyViewedMovie] {
        try local.fetch(limit: limit)
    }
    
    func clearAll() async throws {
        try local.clearAll()
    }
}
