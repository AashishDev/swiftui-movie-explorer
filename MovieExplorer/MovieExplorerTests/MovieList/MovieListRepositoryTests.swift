//
//  MovieListRepositoryTests.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import Testing
@testable import MovieExplorer

@MainActor
struct MovieListRepositoryTests {

    @Test
    func fetchMovies_returnsRemoteData() async throws {

        let remote = MockRemoteDataSource()
        remote.result = .success([
            Movie(id: "101", title: "a movie",description: "a description",imageURL: "")
        ])

        let repository = MovieListRepository(remote: remote, local: MockLocalMoviesDataSource())
        let result = try await repository.fetchMovies()

        #expect(result.count == 1)
        #expect(result.first?.title == "a movie")
    }
}
