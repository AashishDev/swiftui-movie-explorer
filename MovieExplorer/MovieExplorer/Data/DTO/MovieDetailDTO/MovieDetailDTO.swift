//
//  MovieDetailDTO.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

struct MovieDetailDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
}
