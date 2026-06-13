//
//  MovieListRepository.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

protocol MovieListRepositoryProtocol {
    func fetchMovies() async throws -> [Movie]
}

final class MovieListRepository: MovieListRepositoryProtocol {
    private let dataSource: MoviesListDataSourceProtocol
    
    init(dataSource: MoviesListDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func fetchMovies() async throws -> [Movie] {
        try await self.dataSource.fetchMovies()
    }
}
