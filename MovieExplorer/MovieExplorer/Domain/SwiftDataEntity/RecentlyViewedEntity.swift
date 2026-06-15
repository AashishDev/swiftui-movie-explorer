//
//  RecentlyViewedEntity.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import SwiftData
import Foundation

@Model
final class RecentlyViewedEntity {

    @Attribute(.unique)
    var id: String

    var title: String
    var viewedAt: Date

    init(
        id: String,
        title: String,
        viewedAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.viewedAt = viewedAt
    }
}
