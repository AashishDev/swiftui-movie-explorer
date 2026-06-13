//
//  MoviesResponse.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

struct MoviesResponseDTO: Decodable,Sendable {
    let results: [MovieDTO]
}

