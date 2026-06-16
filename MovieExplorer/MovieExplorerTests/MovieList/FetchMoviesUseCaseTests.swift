//
//  FetchMoviesUseCaseTests.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Testing
@testable import MovieExplorer
import Foundation

@MainActor
struct FetchMoviesUseCaseTests {

    @Test
    func fetchMoviesUseCase_returnsMovies_successfully() async throws {
        let repo = MockMovieRepository()
        repo.result = .success([
            Movie(id: "101", title: "Test", description: " a description",imageURL:"")
        ])

        let useCase = FetchMoviesUseCase(repository: repo)
        let result = try await useCase.execute(forceRefresh: false)

        #expect(result.count == 1)
        #expect(result.first?.title == "Test")
    }

    @Test
    func fetchMoviesUseCase_throwsError_OnFailedConnection() async {

        let repo = MockMovieRepository()
        repo.result = .failure(URLError(.notConnectedToInternet))

        let useCase = FetchMoviesUseCase(repository: repo)
        await #expect(throws: URLError.self) {
            _ = try await useCase.execute(forceRefresh: false)
        }
    }
}
