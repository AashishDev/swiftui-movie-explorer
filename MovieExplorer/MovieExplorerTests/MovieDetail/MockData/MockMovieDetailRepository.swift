//
//  MockMovieDetailRepository.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/14/26.
//
import Testing
@testable import MovieExplorer

final class MockMovieDetailRepository: MovieDetailRepositoryProtocol {
    var result: Result<MovieDetail, Error>!

    func fetchDetail(for id: String) async throws -> MovieDetail {
        try result.get()
    }
}
