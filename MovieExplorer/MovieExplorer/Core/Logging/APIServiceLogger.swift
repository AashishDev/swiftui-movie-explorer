//
//  APIServiceLogger.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation

class APIServiceLogger:APIServiceProtocol {
    private let decoratee:APIServiceProtocol
    init(decoratee:APIServiceProtocol) {
        self.decoratee = decoratee
    }
    
    func execute(urlRequest: URLRequest) async throws -> (Data, HTTPURLResponse) {
        print("""
                API REQUEST
                URL: \(urlRequest.url?.absoluteString ?? "")
                METHOD: \(urlRequest.httpMethod ?? "GET")
                """)
        
        do {
            let (data,response) = try await decoratee.execute(urlRequest: urlRequest)
            print("""
                       HTTP RESPONSE: \(response)
                       Data SIZE: \(data.count) bytes
                       """)
            return (data,response)
        }
        catch {
            print("API ERROR: \(error)")
            throw error
        }
    }
}
