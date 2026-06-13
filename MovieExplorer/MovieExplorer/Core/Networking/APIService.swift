//
//  APIService.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation

class APIService:APIServiceProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func execute(urlRequest: URLRequest) async throws -> (Data, HTTPURLResponse) {
       
        do {
            let (data,response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard httpResponse.isSuccessful else {
                throw APIError.httpError(statusCode: httpResponse.statusCode, data: data)
            }
            
            return (data,httpResponse)
        }
        catch {
            throw APIError.serverError(error)
        }
    }
}
