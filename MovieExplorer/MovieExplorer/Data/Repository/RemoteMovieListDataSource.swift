//
//  MovieRemoteDataSource.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation

protocol MoviesListDataSourceProtocol {
    func fetchMovies() async throws -> [Movie]
}

class MovieRemoteDataSource: MoviesListDataSourceProtocol {
    let service:APIServiceProtocol
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func fetchMovies() async throws -> [Movie] {
        
        let apiURL = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=11c5d3b2a72c53e38a4b740b08d28921")!
        let (data,_) = try await service.execute(urlRequest:URLRequest(url: apiURL))
        
        do {
            let responseDTO = try JSONDecoder().decode(
                MoviesResponseDTO.self,
                from: data
            )
            return responseDTO.results.map { $0.toDomain()}
        }
        catch {
            throw APIError.decodingError
        }
        
    }
}
