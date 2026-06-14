//
//  RemoteMovieDetailDataSourceTests.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/14/26.
//

import Testing
import Foundation
@testable import MovieExplorer

@MainActor
struct RemoteMovieDetailDataSourceTests {

    @Test
    func fetchDetail_success_decodesCorrectly() async throws {

        let json = """
        {
            "id": 1,
            "title": "Decoded Movie",
            "description": "Some desc",
            "rating": 8.7
        }
        """.data(using: .utf8)!

        let service = MockAPIService()
        service.result = .success((json, HTTPURLResponse()))

        let dataSource = RemoteMovieDetailDataSource(service: service)

        do {
            let result = try await dataSource.fetchDetail(for: 1)
            
            #expect(result.id == 1)
            #expect(result.title == "Decoded Movie")
            #expect(result.rating == 8.7)
        }
        catch {
            print(error)
        }
    }

    @Test
    func fetchDetail_invalidJSON_throwsDecodingError() async {

        let service = MockAPIService()
        service.result = .success((Data("bad json".utf8), HTTPURLResponse()))

        let dataSource = RemoteMovieDetailDataSource(service: service)

        await #expect(throws: APIError.self) {
            _ = try await dataSource.fetchDetail(for: 1)
        }
    }
}
