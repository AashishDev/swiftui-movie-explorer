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
    func movieDetailViewModel_OnSuccess_andMovieInRecentlyViewed() async {

        let movie = MovieDetail(
            id: 1,
            title: "a title",
            description: "a description"
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
        #expect(result.title == "a title")
        #expect(recently.addedMovie?.id == 1)
    }

    @Test
    func movieDetailViewModel_OnApiFailure_setsErrorState() async {

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
}
