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
    private let remote: RemoteMoviesDataSourceProtocol
    
    init(remote: RemoteMoviesDataSourceProtocol) {
        self.remote = remote
    }
    
    func fetchMovies() async throws -> [Movie] {
        try await self.remote.fetchMovies()
    }
}
