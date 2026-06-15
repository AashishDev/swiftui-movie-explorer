//
//  MovieListViewModelTests.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Testing
@testable import MovieExplorer
import Foundation

@MainActor
struct MovieListViewModelTests {
    
    @Test
    func movieListViewModel_OnSuccessfulLoad_updatesStateAndRecentlyViewed() async {
        
        let repo = MockMovieRepository()
        repo.result = .success([
            Movie(id: "101", title: "a title", description: "a description", imageURL: "")
        ])
        
        let useCase =  FetchMoviesUseCase(repository: repo)
        let recently = MockRecentlyViewedUseCase()
        recently.items = [
            RecentlyViewedMovie(id: "101", title: "Old Movie", viewedAt: Date())
        ]
        
        let vm = MovieListViewModel(
            useCase: useCase,
            recentlyViewedUseCase: recently
        )
        await vm.load()
        
        guard case let .loaded(movies) = vm.state else {
            Issue.record("Expected .loaded state but got \(vm.state)")
            return
        }
        
        #expect(movies.count == 1)
        #expect(vm.recentlyViewed.count == 1)
    }
    
    @Test
    func movieListViewModel_OnFailure_setsErrorState() async {
        
        let repo = MockMovieRepository()
        repo.result = .failure(APIError.invalidResponse)
        
        let useCase = FetchMoviesUseCase(repository: repo)
        
        let vm = MovieListViewModel(
            useCase: useCase,
            recentlyViewedUseCase: MockRecentlyViewedUseCase()
        )
        
        await vm.load()
        
        if case .error = vm.state {
            #expect(true)
        } else {
            Issue.record("Expected error state")
        }
    }
    
    @Test
    func movieListViewModel_clearRecentlyViewed_removesItems() async {
        
        let recently = MockRecentlyViewedUseCase()
        recently.items = [
            RecentlyViewedMovie(id: "101", title: "A", viewedAt: Date())
        ]
        
        let vm = MovieListViewModel(
            useCase: FetchMoviesUseCase(repository: MockMovieRepository()),
            recentlyViewedUseCase: recently
        )
        
        await vm.clearRecentlyViewed()
        #expect(vm.recentlyViewed.isEmpty)
    }
}
