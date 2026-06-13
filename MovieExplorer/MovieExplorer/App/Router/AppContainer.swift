//
//  AppContainer.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

//Composition Root
final class AppContainer {
    
    func makeMovieListViewModel() -> MovieListViewModel {
        
        let service =  APIServiceLogger(
            decoratee: APIService()
        )
        
        let dataSource = MovieRemoteDataSource(
            service: service
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
