//
//  Environment.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Foundation

enum Environment {
    
    static var apiKey:String {
       guard let value = Bundle.main.object(
            forInfoDictionaryKey: "MVDB_API_KEY"
        ) as? String else {
            fatalError("The Movie DB API Key is missing")
        }
        return value
    }
    
    static var baseURL:URL? {
        guard let value =  Bundle.main.object(forInfoDictionaryKey: "BASE_URL"
        ) as? String else {
            fatalError("Application Base url is missing")
        }
        return URL(string: value)
    }
}
