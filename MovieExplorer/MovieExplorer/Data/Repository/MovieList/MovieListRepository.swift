//
//  MovieListRepository.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation
protocol MovieListRepositoryProtocol {
    func fetchMovies(forceRefresh:Bool) async throws -> [Movie]
}

final class MovieListRepository: MovieListRepositoryProtocol {
    private let remote: RemoteMoviesDataSourceProtocol
    private let local: LocalMoviesDataSourceProtocol

    init(remote: RemoteMoviesDataSourceProtocol,
         local: LocalMoviesDataSourceProtocol) {
        self.remote = remote
        self.local = local
    }
    
    func fetchMovies(forceRefresh:Bool) async throws -> [Movie] {
       
        //Load data from local db firstly
        if !forceRefresh {
            let local = try await self.local.fetchMovies()
            if !local.isEmpty {
                return local
            }
        }
        
        //If no Local data available then fetch from remote services
        let remoteMovies = try await remote.fetchMovies()
        try await local.saveMovies(remoteMovies)
        return remoteMovies
    }
}
