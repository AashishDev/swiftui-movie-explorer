//
//  RecentlyViewedLocalDataSource.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import SwiftData
import Foundation

protocol RecentlyViewedLocalDataSourceProtocol {
    func add(movie: MovieDetail) throws
    func fetch(limit: Int) throws -> [RecentlyViewedMovie]
    func clearAll() throws
}

@MainActor
final class RecentlyViewedLocalDataSource:
    RecentlyViewedLocalDataSourceProtocol {

    private let context: ModelContext
    init(context: ModelContext) {
        self.context = context
    }

    func add(movie: MovieDetail) throws {
        let id = movie.id
        
//        let descriptor = FetchDescriptor<RecentlyViewedEntity>(
//            predicate: #Predicate { $0.id == id }
//        )
//        
//        if let existing = try context.fetch(descriptor).first {
//            // Update timestamp instead insert duplicate
//            existing.viewedAt = Date()
//        } else {
//            let entity = RecentlyViewedEntity(
//                id: movie.id,
//                title: movie.title,
//                viewedAt: Date()
//            )
//            context.insert(entity)
//        }
//        
//        try context.save()
    }

    func fetch(limit: Int) throws -> [RecentlyViewedMovie] {
        let descriptor = FetchDescriptor<RecentlyViewedEntity>(
            sortBy: [
                SortDescriptor(\.viewedAt, order: .reverse)
            ]
        )

        let entities = try context.fetch(descriptor)
        let movies =  entities.prefix(limit).map {
            RecentlyViewedMovie(
                id: $0.id,
                title: $0.title,
                viewedAt: $0.viewedAt
            )
        }
        return movies
    }

    func clearAll() throws {

        let entities = try context.fetch(
            FetchDescriptor<RecentlyViewedEntity>()
        )

        entities.forEach {
            context.delete($0)
        }

        try context.save()
    }
}
