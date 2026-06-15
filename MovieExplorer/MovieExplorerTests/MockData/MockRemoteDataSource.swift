//
//  MockRemoteDataSource.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Testing
@testable import MovieExplorer

final class MockRemoteDataSource: RemoteMoviesDataSourceProtocol {
    var result: Result<[Movie], Error> = .success([])

    func fetchMovies() async throws -> [Movie] {
        try result.get()
    }
}


final class MockLocalMoviesDataSource: LocalMoviesDataSourceProtocol {
    func fetchMovies() async throws -> [MovieExplorer.Movie] {
        return []
    }
    
    func saveMovies(_ movies: [MovieExplorer.Movie]) async throws {
    }
}
