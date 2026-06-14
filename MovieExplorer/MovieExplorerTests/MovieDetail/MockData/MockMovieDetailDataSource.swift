//
//  MockMovieDetailDataSource.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/14/26.
//

import Testing
@testable import MovieExplorer

final class MockMovieDetailDataSource: RemoteMovieDetailDataSourceProtocol {

    var result: Result<MovieDetail, Error>!

    func fetchDetail(for movieId: Int) async throws -> MovieDetail {
        try result.get()
    }
}
