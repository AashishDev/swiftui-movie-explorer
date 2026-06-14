//
//  MovieDetailRepositoryTests.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/14/26.
//
import Testing
@testable import MovieExplorer

@MainActor
struct MovieDetailRepositoryTests {

    @Test
    func fetchDetail_returnsMovieFromDataSource() async throws {

        let dataSource = MockMovieDetailDataSource()

        let expected = MovieDetail(
            id: 10,
            title: "Repo Movie",
            description: "Repo Desc",
            rating: 9.1
        )

        dataSource.result = .success(expected)

        let repo = MovieDetailRepository(dataSource: dataSource)
        let result = try await repo.fetchDetail(for: 10)

        #expect(result.id == 10)
        #expect(result.title == "Repo Movie")
    }
}
