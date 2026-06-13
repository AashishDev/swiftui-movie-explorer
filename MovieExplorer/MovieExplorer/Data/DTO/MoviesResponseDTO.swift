//
//  MoviesResponse.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

struct MoviesResponse: Decodable,Sendable {
    let results: [MovieDTO]
}

