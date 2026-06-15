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

    private let movieId: String
    private let fetchMovieDetailUseCase: MovieDetailUseCaseProtocol
    private let recentlyViewedUseCase: RecentlyViewedUseCaseProtocol

    init(
        movieId: String,
        fetchMovieDetailUseCase: MovieDetailUseCaseProtocol,
        recentlyViewedUseCase: RecentlyViewedUseCaseProtocol
    ) {
        self.movieId = movieId
        self.fetchMovieDetailUseCase = fetchMovieDetailUseCase
        self.recentlyViewedUseCase = recentlyViewedUseCase
    }
    
    func load() async {
        state = .loading
        
        do {
            let movie = try await fetchMovieDetailUseCase
                .getDetail(for: movieId)
            await recentlyViewedMovie(for: movie)
            state = .loaded(movie)

        } catch let apiError as APIError {
            state = .error(apiError)
        } catch {
            state = .error(
                .serverError(error)
            )
        }
    }
    
    func recentlyViewedMovie(for movie:MovieDetail) async {
        do {
            try await recentlyViewedUseCase.add(movie: movie)
        } catch {
            print("Failed to save recently viewed movie: \(error)")
        }
    }
}
