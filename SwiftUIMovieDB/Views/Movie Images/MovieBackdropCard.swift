//
//  MovieBackdropCard.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 21.08.2023.
//

import SwiftUI

struct MovieBackdropCard: View {
    
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(color: .white, radius: 100)
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path ?? "")")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                            .shadow(color: .white, radius: 100)
                    } else if phase.error != nil {
                        Text("There was an error loading the image.")
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    } else {
                        ProgressView()
                    }
                }
            }
            .frame(width: 272, height: 153)
            
            Text(movie.title)
                .font(.system(size: 20, weight: .medium))
                .frame(width: 270, height: 50, alignment: .leading)
                .lineLimit(2)
        }
    }
}

//struct MovieBackdropCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieBackdropCard()
//    }
//}
