//
//  MovieCellView.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import SwiftUI


struct MovieCellView:View {
    let movie: Movie
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(movie.title)
                .font(.headline)
            Text(movie.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }.padding(.vertical, 4)
    }
}
