//
//  MoviesResponse.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

struct MoviesResponseDTO: Decodable,Sendable {
    let results: [MovieDTO]
}

// - https://api.themoviedb.org/3/movie/popular?api_key=11c5d3b2a72c53e38a4b740b08d28921
