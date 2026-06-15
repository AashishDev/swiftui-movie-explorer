//
//  MockMovieDetailUseCase.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/14/26.
//

import Testing
@testable import MovieExplorer


final class MockMovieDetailUseCase: MovieDetailUseCaseProtocol {
    var result: Result<MovieDetail, Error>!

    func getDetail(for id: String) async throws -> MovieDetail {
        try result.get()
    }
}
