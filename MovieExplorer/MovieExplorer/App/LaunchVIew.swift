//
//  Untitled.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/16/26.
//

import SwiftUI

struct LaunchView: View {
    
    var body: some View {

        VStack(spacing: 20) {
            Image(systemName: "film.stack")
                .font(.system(size: 60))

            Text("Movie Explorer")
                .font(.largeTitle)
                .fontWeight(.bold)

            ProgressView()
        }
    }
}
