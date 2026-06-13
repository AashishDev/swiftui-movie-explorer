//
//  UIConstant.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import Foundation

enum UIConstants {

    enum Title {
        static let movies = "Movies"
        static let recentlyViewed = "Recently Viewed"
        static let popularMovies = "Popular Movies"
        static let movieDetail = "Movies Detail"
    }
    
    enum ProgressView {
        static let msg = "Loading Movies..."
    }
    enum ErrorState {
        static let noMovies =  "Unable to Load Movies"
    }
    
    enum Button {
        static let retry = "Retry"
    }
    
    enum Images {
        static let errorIcon = "exclamationmark.triangle"
        static let deleteIcon = "trash"

    }
    

    enum Layout {
        static let cardWidth: CGFloat = 150
        static let spacing: CGFloat = 12
    }
}
