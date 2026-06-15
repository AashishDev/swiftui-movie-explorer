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
    func movieDetailRepository_fetchDetail_returnsMovies() async throws {

        let dataSource = MockMovieDetailDataSource()

        let expected = MovieDetail(
            id: "101",
            title: "a Movie",
            description: "a Desc",
            rating: "9"
        )

        dataSource.result = .success(expected)

        let repo = MovieDetailRepository(dataSource: dataSource)
        let result = try await repo.fetchDetail(for: "101")

        #expect(result.id == "101")
        #expect(result.title == "a Movie")
    }
}
