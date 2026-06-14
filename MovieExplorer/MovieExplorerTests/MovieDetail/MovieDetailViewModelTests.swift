//
//  MovieDetailViewModelTests.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/14/26.
//

import Testing
@testable import MovieExplorer

@MainActor
struct MovieDetailViewModelTests {

    @Test
    func load_success_updatesState_andCallsRecentlyViewed() async {

        let movie = MovieDetail(
            id: 1,
            title: "Inception",
            description: "Dream",
            rating: 9.5
        )

        let useCase = MockMovieDetailUseCase()
        useCase.result = .success(movie)

        let recently = MockDetailRecentlyViewedUseCase()

        let vm = MovieDetailViewModel(
            movieId: 1,
            fetchMovieDetailUseCase: useCase,
            recentlyViewedUseCase: recently
        )

        await vm.load()

        guard case let .loaded(result) = vm.state else {
            Issue.record("Expected loaded state but got \(vm.state)")
            return
        }

        #expect(result.id == 1)
        #expect(result.title == "Inception")
        #expect(recently.addedMovie?.id == 1)
    }

    @Test
    func load_failure_setsErrorState() async {

        let useCase = MockMovieDetailUseCase()
        useCase.result = .failure(APIError.decodingError)

        let vm = MovieDetailViewModel(
            movieId: 1,
            fetchMovieDetailUseCase: useCase,
            recentlyViewedUseCase: MockRecentlyViewedUseCase()
        )

        await vm.load()

        guard case .error = vm.state else {
            Issue.record("Expected error state but got \(vm.state)")
            return
        }

        #expect(true)
    }

    @Test
    func recentlyViewed_isTriggered_onSuccess() async {

        let movie = MovieDetail(
            id: 99,
            title: "Test",
            description: "",
            rating: 0
        )

        let useCase = MockMovieDetailUseCase()
        useCase.result = .success(movie)

        let recently = MockDetailRecentlyViewedUseCase()

        let vm = MovieDetailViewModel(
            movieId: 99,
            fetchMovieDetailUseCase: useCase,
            recentlyViewedUseCase: recently
        )

        await vm.load()

        #expect(recently.addedMovie?.id == 99)
    }
}
