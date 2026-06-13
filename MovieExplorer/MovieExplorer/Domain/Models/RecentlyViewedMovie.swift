//
//  Untitled.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import Foundation

struct RecentlyViewedMovie: Identifiable, Equatable {
    let id: Int
    let title: String
    let viewedAt: Date
    
    var displayDate:String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: viewedAt)
    }
}
