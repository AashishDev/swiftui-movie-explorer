//
//  APIEndPoint.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation

enum MovieEndPoint {
    case popularMovies
    case details(id: Int)
    case markFavorite(id: Int)
    
    private var method:HTTPMethod {
        switch self {
        case .popularMovies:
            return .get
        case .details:
            return .get
        case .markFavorite:
            return .post
        }
    }
    
    private var queryItems: [URLQueryItem] {
        return [
            URLQueryItem(
                name: "api_key",
                value: Environment.apiKey
            )
        ]
    }
    
    func makeRequest() throws -> URLRequest {
        
        var components =  URLComponents(url:Environment.baseURL!,
                                        resolvingAgainstBaseURL:false)
        switch self {
        case .popularMovies:
            components?.path = "/3/movie/popular"
            components?.queryItems = queryItems
        case .details(id: let id):
            components?.path = "/3/movie/\(id)"
            components?.queryItems = queryItems
            
        case .markFavorite(id: let id):
            components?.path = "/3/movie/\(id)/watchlist"
            components?.queryItems = queryItems
        }
        
        guard let url =  components?.url else {
            throw APIError.invalidResponse
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
}


