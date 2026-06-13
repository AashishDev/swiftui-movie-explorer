//
//  AppContainer.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation

@MainActor
@Observable
final class AppContainer {
    let router = Router()
    
    func makeMovieListViewModel() -> MovieListViewModel {
        
        let apiService = APIServiceLogger(
            decoratee: APIService()
        )
        
        let dataSource = MovieRemoteDataSource(
            service: apiService
        )
        
        let repository = MovieListRepository(
            dataSource: dataSource
        )
        
        let useCase = FetchMoviesUseCase(
            repository: repository
        )
        
        return MovieListViewModel(
            useCase: useCase
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
        
        return MovieDetailViewModel(
            movieId: movieId,
            fetchMovieDetailUseCase: useCase
        )
    }
}
