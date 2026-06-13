//
//  AppContainer.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

//Composition Root
final class AppContainer {
    
    private lazy var apiService: APIServiceProtocol = {
        APIServiceLogger(
            decoratee: APIService()
        )
    }()
    
    func makeMovieListViewModel() -> MovieListViewModel {

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
            fetchMoviesUseCase: useCase
        )
    }
}
