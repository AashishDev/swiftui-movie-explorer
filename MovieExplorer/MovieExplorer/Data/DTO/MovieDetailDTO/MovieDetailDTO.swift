//
//  MovieDetailDTO.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

struct MovieDetailDTO: Decodable, Sendable {

    let id: Int
    let title: String
    let description: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case voteAverage = "vote_average"
    }
}

extension MovieDetailDTO {
   
    func toDomain() -> MovieDetail {
        MovieDetail(
            id: id,
            title: title,
            description: description,
            rating: voteAverage
        )
    }
}
