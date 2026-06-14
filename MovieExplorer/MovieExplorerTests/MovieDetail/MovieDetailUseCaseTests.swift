//
//  Untitled.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/14/26.
//
import Testing
@testable import MovieExplorer

@MainActor
struct MovieDetailUseCaseTests {

    @Test
    func execute_success_returnsMovieDetail() async throws {

        let repo = MockMovieDetailRepository()

        let expected = MovieDetail(
            id: 1,
            title: "UseCase Movie",
            description: "Desc",
            rating: 8.0
        )

        repo.result = .success(expected)

        let useCase = MovieDetailUseCase(repository: repo)

        let result = try await useCase.getDetail(for: 1)

        #expect(result.title == "UseCase Movie")
        #expect(result.rating == 8.0)
    }

    @Test
    func execute_failure_throwsError() async {

        let repo = MockMovieDetailRepository()
        repo.result = .failure(APIError.decodingError)

        let useCase = MovieDetailUseCase(repository: repo)

        await #expect(throws: APIError.self) {
            _ = try await useCase.getDetail(for: 1)
        }
    }
}
