//
//  MockAPIService.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Testing
import Foundation
@testable import MovieExplorer

final class MockAPIService: APIServiceProtocol {

    var result: Result<(Data, HTTPURLResponse), Error> = .success((Data(), HTTPURLResponse()))

    func execute(urlRequest: URLRequest) async throws -> (Data, HTTPURLResponse) {
        try result.get()
    }
}
