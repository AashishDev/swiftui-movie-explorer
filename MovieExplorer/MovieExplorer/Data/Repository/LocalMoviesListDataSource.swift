//
//  LocalMoviesListDataSource.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import Foundation

class LocalMoviesListDataSource: MoviesListDataSourceProtocol {
    let service:APIServiceProtocol
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func fetchMovies() async throws -> [Movie] {
        
        let apiURL = URL(string:"http://api.themoviedb.org/3/movie/popular")!
        _ = try await service.execute(urlRequest:URLRequest(url: apiURL))
        
        return []
    }
}
