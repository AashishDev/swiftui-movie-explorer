//
//  Environment.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation

enum AppEnvironment {
    
    static var baseURL:URL? {
        guard let value =  Bundle.main.object(forInfoDictionaryKey: "BASE_URL"
        ) as? String else {
            fatalError("Application Base url is missing")
        }
        return URL(string: value)
    }
}
