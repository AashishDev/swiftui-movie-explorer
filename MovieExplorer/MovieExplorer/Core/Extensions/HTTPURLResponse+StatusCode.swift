//
//  HTTPURLResponse+StatusCode.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation

extension HTTPURLResponse {
    private static var SUCCESS_200: Int { 200 }
    
    var isSuccessful: Bool { statusCode == HTTPURLResponse.SUCCESS_200 }
}
