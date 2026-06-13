//
//  MovieDetailViewModel.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//


import Observation

enum MovieDetailState: Equatable {
    case idle
    case loading
    case loaded(MovieDetail)
    case error(APIError)
}

@MainActor
@Observable
final class MovieDetailViewModel {

    private(set) var state: MovieDetailState = .idle

    private let movieId: Int
    private let fetchMovieDetailUseCase: MovieDetailUseCaseProtocol

    init(
        movieId: Int,
        fetchMovieDetailUseCase: MovieDetailUseCaseProtocol
    ) {
        self.movieId = movieId
        self.fetchMovieDetailUseCase = fetchMovieDetailUseCase
    }

    func load() async {
        state = .loading

        do {
            let movie = try await fetchMovieDetailUseCase
                .getDetail(for: movieId)
            state = .loaded(movie)

        } catch let apiError as APIError {
            state = .error(apiError)
        } catch {
            state = .error(
                .serverError(error)
            )
        }
    }
}
