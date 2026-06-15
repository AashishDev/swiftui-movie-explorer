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

        let movieID = movie.id

        let descriptor = FetchDescriptor<RecentlyViewedEntity>(
            predicate: #Predicate {
                $0.id == movieID
            }
        )

        if let existing = try context.fetch(descriptor).first {
            existing.viewedAt = .now
        } else {
            context.insert(
                RecentlyViewedEntity(
                    id: movie.id,
                    title: movie.title
                )
            )
        }

        try context.save()
    }

    func fetch(limit: Int) throws -> [RecentlyViewedMovie] {

           var descriptor = FetchDescriptor<RecentlyViewedEntity>(
               sortBy: [
                   SortDescriptor(\.viewedAt, order: .reverse)
               ]
           )

           descriptor.fetchLimit = limit

           return try context.fetch(descriptor).map {
               RecentlyViewedMovie(
                   id: $0.id,
                   title: $0.title,
                   viewedAt: $0.viewedAt
               )
           }
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
