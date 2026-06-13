//
//  ErrorStateView.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import SwiftUI

struct ErrorStateView: View {

    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: UIConstants.Images.errorIcon)
                .font(.largeTitle)

            Text(UIConstants.ErrorState.noMovies)
                .font(.headline)

            Text(message)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button(UIConstants.Button.retry, action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
