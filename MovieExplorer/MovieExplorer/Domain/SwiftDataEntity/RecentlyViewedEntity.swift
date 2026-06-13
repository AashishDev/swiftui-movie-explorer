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
    var id: Int

    var title: String
    var viewedAt: Date

    init(
        id: Int,
        title: String,
        viewedAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.viewedAt = viewedAt
    }
}
