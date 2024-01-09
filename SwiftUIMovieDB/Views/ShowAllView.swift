//
//  ShowAllView.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 22.08.2023.
//

import SwiftUI

struct ShowAllView: View {
    
    @ObservedObject var movieArray = MovieListService()
    
    let endpoint: MovieListEndpoint
    
    var body: some View {
        ScrollView(.vertical) {
            
//            Text(endpoint.self.description + " Movies")
//                .font(.system(size: 30, weight: .heavy))
//                .frame(alignment: .leading)
//                .padding(20)
            LazyVStack {
                ForEach(movieArray.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                        ShowAllMovieCard(movie: movie)
                    }.buttonStyle(PlainButtonStyle())
                        .onAppear {
                            if movie.id == movieArray.movies.last?.id {
                                self.movieArray.loadNewPage(endpoint: endpoint)
                            }
                        }
                }
            }
            .navigationTitle(endpoint.self.description + " Movies")
        }
        .refreshable{
            self.movieArray.handleRefresh(endpoint: endpoint)
        }
        .background(Color.gray.opacity(0.5))
    }
}

struct ShowAllView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllView(endpoint: .nowPlaying)
    }
}
