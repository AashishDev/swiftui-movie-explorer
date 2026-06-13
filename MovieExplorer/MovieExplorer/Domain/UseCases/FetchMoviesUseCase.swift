//
//  FetchMoviesUseCase.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

//-Filtering, Pagination, Business Rules
protocol FetchMoviesUseCaseProtocol {
    func execute() async throws -> [Movie]
}

class FetchMoviesUseCase: FetchMoviesUseCaseProtocol {
    private let repository: MovieListRepositoryProtocol
    
    init(repository: MovieListRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Movie] {
        try Task.checkCancellation()
        return try await repository.fetchMovies()
    }
}
