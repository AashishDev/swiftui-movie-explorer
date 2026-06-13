//
//  MovieRemoteDataSource.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation

protocol RemoteMoviesDataSourceProtocol {
    func fetchMovies() async throws -> [Movie]
}

class MovieRemoteDataSource: RemoteMoviesDataSourceProtocol {
    let service:APIServiceProtocol
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func fetchMovies() async throws -> [Movie] {
        let request = try MovieEndPoint.popularMovies.makeRequest()
        let (data,_) = try await service.execute(urlRequest:request)
        
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
