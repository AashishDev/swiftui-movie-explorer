//
//  MovieDTO.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

struct MovieDTO:Decodable,Sendable {
    let id:Int
    let title:String
    let description:String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
    }
}

extension MovieDTO {
    func toDomain() -> Movie {
        Movie(
            id: id,
            title: title,
            description: description,
            isFavorite: false
        )
    }
}
