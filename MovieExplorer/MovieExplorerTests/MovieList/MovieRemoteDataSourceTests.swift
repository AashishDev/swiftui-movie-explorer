//
//  MovieRemoteDataSourceTests.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Testing
import Foundation
@testable import MovieExplorer

@MainActor
struct MovieRemoteDataSourceTests {

    @Test
    func movieRemoteDataSource_fetchMovies_successfulDecoding() async throws {
        let json = """
        {
            "results": [
                {
                    "id": 1,
                    "title": "a title",
                    "overview": "This is a great movie description."
                }
            ]
        }
        """.data(using: .utf8)!
        
        
        let service = MockAPIService()
        service.result = .success((json, HTTPURLResponse()))
        
        let dataSource = MovieRemoteDataSource(service: service)
        
        //Execute the function
        let movies = try await dataSource.fetchMovies()
        
        //Verify the properties
        #expect(movies.count == 1)
        #expect(movies.first?.id == 1)
        #expect(movies.first?.title == "a title")
        #expect(movies.first?.description == "This is a great movie description.")
    }

    @Test
    func movieRemoteDataSource_fetchMoviesWithInValidJSON_throwsDecodingError() async {
        let invalidJSON = Data("invalid json".utf8)

        let service = MockAPIService()
        service.result = .success((invalidJSON, HTTPURLResponse()))

        let dataSource = MovieRemoteDataSource(service: service)

        await #expect(throws: APIError.self) {
            _ = try await dataSource.fetchMovies()
        }
    }

    @Test
    func movieRemoteDataSource_fetchMoviesWithApiFailure_throwsError() async {
        let service = MockAPIService()
        service.result = .failure(APIError.networkUnavailable)

        let dataSource = MovieRemoteDataSource(service: service)

        await #expect(throws: Error.self) {
            _ = try await dataSource.fetchMovies()
        }
    }
}
