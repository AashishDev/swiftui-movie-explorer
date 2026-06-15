//
//  MovieEntity.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/15/26.
//

import SwiftData

@Model
final class MovieEntity {

    @Attribute(.unique)
    var id: String

    var title: String
    var dscription: String
    var imageURL: String

    init(
        id: String,
        title: String,
        dscription: String,
        imageURL: String
    ) {
        self.id = id
        self.title = title
        self.dscription = dscription
        self.imageURL = imageURL
    }
}

extension MovieEntity {

    func toDomain() -> Movie {
        Movie(
            id: id,
            title: title,
            description: dscription,
            imageURL: imageURL
        )
    }
}
