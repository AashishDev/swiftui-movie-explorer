//
//  Movie.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

struct Movie: Identifiable, Hashable,Equatable {
    let id: String
    let title: String
    let description: String
    var imageURL: String
}

extension Movie {

    func toEntity() -> MovieEntity {
        MovieEntity(
            id: id,
            title: title,
            dscription: description,
            imageURL: imageURL
        )
    }
}
