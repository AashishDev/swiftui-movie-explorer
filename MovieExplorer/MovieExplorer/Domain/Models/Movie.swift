//
//  Movie.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

struct Movie: Identifiable, Hashable,Equatable {
    let id: Int
    let title: String
    let description: String
    var isFavourite: Bool
}

