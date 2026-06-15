//
//  MovieListRepository.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation
protocol MovieListRepositoryProtocol {
    func fetchMovies() async throws -> [Movie]
}

final class MovieListRepository: MovieListRepositoryProtocol {
    private let remote: RemoteMoviesDataSourceProtocol
    private let local: LocalMoviesDataSourceProtocol

    init(remote: RemoteMoviesDataSourceProtocol,
         local: LocalMoviesDataSourceProtocol) {
        self.remote = remote
        self.local = local
    }
    
    func fetchMovies() async throws -> [Movie] {
       
        //Load data from local db firstly
        let localMovies = try await local.fetchMovies()
        
        if !localMovies.isEmpty {

            Task {
                do {
                    let remoteMovies = try await remote.fetchMovies()
                    try await local.saveMovies(remoteMovies)
                } catch {
                    print("Background refresh failed: \(error)")
                }
            }
            return localMovies
        }
        
        //If no Local data available then fetch from remote services
        let remoteMovies = try await remote.fetchMovies()
        try await local.saveMovies(remoteMovies)
        return remoteMovies
    }
}
