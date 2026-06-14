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
            Movie(id: 1, title: "a movie",description: "a description",isFavourite: false)
        ])

        let repository = MovieListRepository(remote: remote)
        let result = try await repository.fetchMovies()

        #expect(result.count == 1)
        #expect(result.first?.title == "a movie")
    }
}
