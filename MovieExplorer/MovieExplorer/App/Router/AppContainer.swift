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
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func makeMovieListViewModel() -> MovieListViewModel {
        
        let apiService = APIServiceLogger(
            decoratee: APIService()
        )
        
        let remoteDataSource = MovieRemoteDataSource(
            service: apiService
        )
        
        let repository = MovieListRepository(
            remote: remoteDataSource
        )
        
        let useCase = FetchMoviesUseCase(
            repository: repository
        )
        
        let recentlyViewedLocal = RecentlyViewedLocalDataSource(
            context: modelContext
        )
        
        let recentlyViewedRepository = RecentlyViewedRepository(
            local: recentlyViewedLocal
        )
        
        let recentlyViewedUseCase = RecentlyViewedUseCase(
            repository: recentlyViewedRepository
        )
        
        return MovieListViewModel(
            useCase: useCase,
            recentlyViewedUseCase: recentlyViewedUseCase
        )
    }
    
    func makeMovieDetailViewModel(for movieId:Int) -> MovieDetailViewModel {
        
        let apiService = APIServiceLogger(
            decoratee: APIService()
        )
        
        let dataSource = RemoteMovieDetailDataSource(
            service: apiService
        )
        
        let repository = MovieDetailRepository(
            dataSource: dataSource
        )
        
        let useCase = MovieDetailUseCase(
            repository: repository
        )
        
        // Recently Viewed (SwiftData)
        let recentlyViewedLocal = RecentlyViewedLocalDataSource(
            context: modelContext
        )
        
        let recentlyViewedRepository = RecentlyViewedRepository(
            local: recentlyViewedLocal
        )
        
        let recentlyViewedUseCase = RecentlyViewedUseCase(
            repository: recentlyViewedRepository
        )
        
        return MovieDetailViewModel(
            movieId: movieId,
            fetchMovieDetailUseCase: useCase, recentlyViewedUseCase: recentlyViewedUseCase
        )
    }
    
    func makeRecentlyViewedUseCase() -> RecentlyViewedUseCaseProtocol {
        
        let local = RecentlyViewedLocalDataSource(
            context: modelContext
        )
        
        let repository = RecentlyViewedRepository(
            local: local
        )
        
        return RecentlyViewedUseCase(
            repository: repository
        )
    }
}
