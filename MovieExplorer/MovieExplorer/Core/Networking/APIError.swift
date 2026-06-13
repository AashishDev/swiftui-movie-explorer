//
//  APIError.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import Foundation

enum APIError: Error,Equatable {
    case networkUnavailable
    case invalidResponse
    case httpError(statusCode:Int,data:Data)
    case serverError(Error)
    case decodingError
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidResponse, .invalidResponse):
            return true
            
        case (.decodingError, .decodingError):
            return true
            
        case let (.httpError(code1, data1), .httpError(code2, data2)):
            return code1 == code2 && data1 == data2
            
        case let (.serverError(error1), .serverError(error2)):
            let ns1 = error1 as NSError
            let ns2 = error2 as NSError
            return ns1.domain == ns2.domain &&
            ns1.code == ns2.code
            
        default:
            return false
        }
    }
    
    var message: String {
           switch self {
           case .networkUnavailable:
               return "Please check your internet connection."

           case .serverError:
               return "Something went wrong on our servers."
               
           case .httpError:
                 return "Unable to load movies right now."

           case .invalidResponse:
               return "Received an invalid response."

           case .decodingError:
               return "Unable to process data."
           }
       }
}


