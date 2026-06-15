//
//  MovieDetailDTO.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

struct MovieDetailDTO: Decodable, Sendable {

    let id: String
    let title: String
    let description: String
    let rating: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description 
        case rating = "rt_score"
    }
}

extension MovieDetailDTO {
   
    func toDomain() -> MovieDetail {
        MovieDetail(
            id: id,
            title: title,
            description: description,
            rating: rating
        )
    }
}
