//
//  MovieCellView.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import SwiftUI

struct MovieCellView: View {
    let movie: Movie
    let reloadID: UUID

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            AsyncImage(url: URL(string: movie.imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .padding(20)

                @unknown default:
                    EmptyView()
                }
            }
            .id(reloadID)
            .frame(width: 120, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 8) {

                Text(movie.title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.primary)

                Text(movie.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}
