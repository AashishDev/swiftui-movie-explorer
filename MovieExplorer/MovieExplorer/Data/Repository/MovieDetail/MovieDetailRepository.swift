//
//  MovieDetailRepository.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import Foundation

protocol MovieDetailRepositoryProtocol {
    func fetchDetail(for id: String) async throws -> MovieDetail
}

final class MovieDetailRepository: MovieDetailRepositoryProtocol {
    private let dataSource: RemoteMovieDetailDataSourceProtocol
    
    init(dataSource: RemoteMovieDetailDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func fetchDetail(for id: String) async throws -> MovieDetail {
        try await self.dataSource.fetchDetail(for: id)
    }
}
