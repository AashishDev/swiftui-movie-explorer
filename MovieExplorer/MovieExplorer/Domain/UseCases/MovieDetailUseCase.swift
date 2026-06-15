//
//  MovieDetailUseCase.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

protocol MovieDetailUseCaseProtocol {
    func getDetail(for id:String) async throws -> MovieDetail
}

final class MovieDetailUseCase: MovieDetailUseCaseProtocol {
    private let repository: MovieDetailRepositoryProtocol
    
    init(repository: MovieDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDetail(for id: String)  async throws -> MovieDetail {
        try Task.checkCancellation()
        
        return try await repository.fetchDetail(
            for: id
        )
    }
}
