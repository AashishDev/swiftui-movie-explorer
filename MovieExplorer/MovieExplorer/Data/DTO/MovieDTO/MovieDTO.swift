//
//  MovieDTO.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

struct MovieDTO:Decodable,Sendable {
    let id:String
    let title:String
    let description:String
    let image: String
}

extension MovieDTO {
    func toDomain() -> Movie {
        Movie(
            id: id,
            title: title,
            description: description,
            imageURL: image
        )
    }
}


