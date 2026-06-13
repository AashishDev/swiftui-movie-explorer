//
//  MovieDetailUseCase.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

protocol MovieDetailUseCaseProtocol {
    func getDetail(for id:Int) -> MovieDetailDTO
}

final class MovieDetailUseCase: MovieDetailUseCaseProtocol {
    func getDetail(for id: Int) -> MovieDetailDTO {
        return .init(id: 1, title: "a title", overview: "a description", posterPath: "a posterPath")
    }
}
