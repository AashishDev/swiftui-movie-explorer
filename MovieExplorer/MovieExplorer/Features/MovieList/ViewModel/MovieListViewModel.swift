//
//  MovieListViewModel.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import Observation

enum MovieListState:Equatable {
    case idle
    case loading
    case loaded([Movie])
    case error(APIError)
}

@MainActor
@Observable
final class MovieListViewModel {
    
    private let network = NetworkMonitor.shared
    private(set) var state: MovieListState = .idle
    var isRefreshing = false
    private(set) var recentlyViewed: [RecentlyViewedMovie] = []
    var refreshErrorMessage: String?
    
    private let useCase: FetchMoviesUseCase
    private let recentlyViewedUseCase: RecentlyViewedUseCaseProtocol
    
    init(useCase: FetchMoviesUseCase,
         recentlyViewedUseCase: RecentlyViewedUseCaseProtocol) {
        self.useCase = useCase
        self.recentlyViewedUseCase = recentlyViewedUseCase
    }
    
    func load() async {
        state = .loading
        do {
            let movies =  try await useCase.execute(forceRefresh:false)
            state = .loaded(movies)
            await loadRecentlyViewed()
        }
        catch let apiError as APIError {
            state =  .error(apiError)
        }
        catch {
            state =  .error(APIError.serverError(error))
        }
    }
    
    func refresh() async {
        isRefreshing = true
        defer { isRefreshing = false }
        guard NetworkMonitor.shared.isConnected  else {
            refreshErrorMessage = APIError.networkUnavailable.message
            Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                await MainActor.run {
                    self.refreshErrorMessage = nil
                }
            }
           return
        }
        do {
            try? await Task.sleep(nanoseconds: 800_000_000)
            let movies =  try await useCase.execute(forceRefresh:true)
            state =  .loaded(movies)
            await loadRecentlyViewed()
        }
        catch let apiError as APIError {
            state =  .error(apiError)
        }
        catch {
            state =  .error(APIError.serverError(error))
        }
    }
}

extension MovieListViewModel {
    func loadRecentlyViewed() async {
        do {
            recentlyViewed = try await recentlyViewedUseCase.fetch(limit: 10)
        } catch {
            recentlyViewed = []
        }
    }
    
    func clearRecentlyViewed() async {
        do {
            try await recentlyViewedUseCase.clearAll()
            recentlyViewed = []
        }
        catch {
            recentlyViewed = []
        }
    }
}
