//
//  MovieDetailDataSource.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import Foundation

protocol RemoteMovieDetailDataSourceProtocol {
    func fetchDetail(for movieId:String) async throws -> MovieDetail
}

class RemoteMovieDetailDataSource: RemoteMovieDetailDataSourceProtocol {
    let service:APIServiceProtocol
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func fetchDetail(for movieId:String) async throws -> MovieDetail {
        let request = try MovieEndPoint.details(id: movieId).makeRequest()
        let (data,_) = try await service.execute(urlRequest:request)
        
        do {
            let responseDTO = try JSONDecoder().decode(
                MovieDetailDTO.self,
                from: data
            )
            return responseDTO.toDomain()
        }
        catch {
            throw APIError.decodingError
        }
        
    }
}
