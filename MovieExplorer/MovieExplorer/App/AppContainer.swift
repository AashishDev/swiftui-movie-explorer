//
//  AppContainer.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation
import SwiftData

@MainActor
@Observable
final class AppContainer {

    let router = Router()
    private let modelContext: ModelContext
    private let apiService: APIServiceProtocol
    let networkState: NetworkState

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.apiService = APIServiceLogger(
            decoratee: APIService()
        )
        self.networkState = NetworkState(
            monitor: NetworkMonitor()
        )
    }

    // MARK: - Movie List
    func makeMovieListViewModel() -> MovieListViewModel {
        let movieUseCase = makeFetchMoviesUseCase()
        let recentlyViewedUseCase = makeRecentlyViewedUseCase()

        return MovieListViewModel(
            useCase: movieUseCase,
            recentlyViewedUseCase: recentlyViewedUseCase,
            networkState: networkState
        )
    }

    // MARK: - Movie Detail
    func makeMovieDetailViewModel(for movieId: String) -> MovieDetailViewModel {

        let useCase = makeMovieDetailUseCase()
        let recentlyViewedUseCase = makeRecentlyViewedUseCase()

        return MovieDetailViewModel(
            movieId: movieId,
            fetchMovieDetailUseCase: useCase,
            recentlyViewedUseCase: recentlyViewedUseCase
        )
    }

    // MARK: - UseCases (Factories)
    private func makeFetchMoviesUseCase() -> FetchMoviesUseCase {

        let remote = MovieRemoteDataSource(service: apiService)
        let local = LocalMoviesDataSource(context:modelContext)

        let repo = MovieListRepository(remote: remote,
                                       local: local)
        
        return FetchMoviesUseCase(repository: repo)
    }

    private func makeMovieDetailUseCase() -> MovieDetailUseCase {

        let remote = RemoteMovieDetailDataSource(service: apiService)
        let repo = MovieDetailRepository(dataSource: remote)

        return MovieDetailUseCase(repository: repo)
    }

    private func makeRecentlyViewedUseCase() -> RecentlyViewedUseCase {

        let local = RecentlyViewedLocalDataSource(context: modelContext)
        let repo = RecentlyViewedRepository(local: local)

        return RecentlyViewedUseCase(repository: repo)
    }
}



