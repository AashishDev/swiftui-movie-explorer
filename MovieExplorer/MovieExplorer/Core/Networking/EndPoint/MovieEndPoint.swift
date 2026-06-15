//
//  APIEndPoint.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation

enum MovieEndPoint {
    case popularMovies
    case details(id: String)
    
    private var method:HTTPMethod {
        switch self {
        case .popularMovies:
            return .get
        case .details:
            return .get
        }
    }
    
    func makeRequest() throws -> URLRequest {
        
        var components =  URLComponents(url:AppEnvironment.baseURL!,
                                        resolvingAgainstBaseURL:false)
        switch self {
        case .popularMovies:
            components?.path = "/films"
        case .details(id: let id):
            components?.path = "/films/\(id)"
        }
        
        guard let url =  components?.url else {
            throw APIError.invalidResponse
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = method.rawValue
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )
        
        return request
    }
    
}


