//
//  ShowAllMovieCard.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 22.08.2023.
//

import SwiftUI

struct ShowAllMovieCard: View {
    
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                    .cornerRadius(2)
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(2)
                    } else if phase.error != nil {
                        Text("There was an error loading the image.")
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    } else {
                        ProgressView()
                    }
                }
            }
            .frame(width: 200, height: 300)
            
            VStack{
                Text(movie.title)
                    .font(.system(size: 16, weight: .heavy))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                Text("(" + (movie.release_date?.substring(from: 0, to: 3) ?? "YYYY") + ")")
                    .font(.system(size: 16, weight: .medium))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
                Text("Rating :  \(String(format: "%.01f", movie.vote_average ))⭐")
                    .font(.system(size: 14, weight: .medium))
                Text(movie.overview ?? "")
                    .font(.system(size: 14, weight: .light))
                    .lineLimit(9)
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .padding(10)
        .background(Color.gray.opacity(0.3))
    }
}

//struct ShowAllMovieCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowAllMovieCard()
//    }
//}
