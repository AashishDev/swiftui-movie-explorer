//
//  MovieDetailResponse.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

struct MovieDetailResponse:Decodable {
    let results: [MovieDetailDTO]
}
