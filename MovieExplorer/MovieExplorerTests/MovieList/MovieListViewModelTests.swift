//
//  MovieListViewModelTests.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Testing
@testable import MovieExplorer

struct MovieListViewModelTests {

    @Test
    func load_success_updatesStateAndRecentlyViewed() async {

        let repo = MockMovieRepository()
        repo.result = .success([
            Movie(id: 1, title: "Movie A")
        ])

        let useCase = FetchMoviesUseCase(repository: repo)

        let recently = MockRecentlyViewedUseCase()
        recently.items = [
            RecentlyViewedMovie(id: 1, title: "Old Movie")
        ]

        let vm = MovieListViewModel(
            useCase: useCase,
            recentlyViewedUseCase: recently
        )

        await vm.load()

        if case let .loaded(movies) = vm.state {
            #expect(movies.count == 1)
        } else {
            #expect(false)
        }

        #expect(vm.recentlyViewed.count == 1)
    }

    @Test
    func load_failure_setsErrorState() async {

        let repo = MockMovieRepository()
        repo.result = .failure(URLError(.badServerResponse))

        let useCase = FetchMoviesUseCase(repository: repo)

        let vm = MovieListViewModel(
            useCase: useCase,
            recentlyViewedUseCase: MockRecentlyViewedUseCase()
        )

        await vm.load()

        if case .error = vm.state {
            #expect(true)
        } else {
            #expect(false)
        }
    }

    @Test
    func clearRecentlyViewed_removesItems() async {

        let recently = MockRecentlyViewedUseCase()
        recently.items = [
            RecentlyViewedMovie(id: 1, title: "A")
        ]

        let vm = MovieListViewModel(
            useCase: FetchMoviesUseCase(repository: MockMovieRepository()),
            recentlyViewedUseCase: recently
        )

        await vm.clearRecentlyViewed()

        #expect(vm.recentlyViewed.isEmpty)
    }
}
