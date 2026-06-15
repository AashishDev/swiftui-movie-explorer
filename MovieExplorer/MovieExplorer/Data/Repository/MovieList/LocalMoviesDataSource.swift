//
//  LocalMoviesDataSource.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/15/26.
//

import SwiftData

protocol LocalMoviesDataSourceProtocol: AnyObject {
    func fetchMovies() async throws -> [Movie]
    func saveMovies(_ movies: [Movie]) async throws
}

class LocalMoviesDataSource: LocalMoviesDataSourceProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchMovies() async throws -> [Movie] {
        let descriptor = FetchDescriptor<MovieEntity>()
        let entities = try context.fetch(descriptor)
        return entities.map { $0.toDomain() }
    }
    
    func saveMovies(_ movies: [Movie]) async throws {
        for movie in movies {
            let entity = movie.toEntity()
            context.insert(entity) // Unique id avoid duplicates
        }
        try context.save()
    }
}
