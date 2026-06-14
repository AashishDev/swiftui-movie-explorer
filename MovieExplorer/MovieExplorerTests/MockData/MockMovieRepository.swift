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

    func fetchMovies() async throws -> [Movie] {
        try result.get()
    }
}
