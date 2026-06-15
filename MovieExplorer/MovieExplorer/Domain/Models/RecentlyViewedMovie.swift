//
//  Untitled.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import Foundation

struct RecentlyViewedMovie: Identifiable, Equatable {

    let id: String
    let title: String
    let viewedAt: Date

    var displayDate: String {
        viewedAt.formatted(
            date: .abbreviated,
            time: .omitted
        )
    }
}
