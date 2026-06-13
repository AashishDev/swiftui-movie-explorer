//
//  APIServiceProtocol.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation

protocol APIServiceProtocol {
    func execute(urlRequest:URLRequest) async throws -> (Data,HTTPURLResponse)
}
