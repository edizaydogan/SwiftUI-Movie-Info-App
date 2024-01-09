//
//  MovieBackdropCarouselView.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 21.08.2023.
//

import SwiftUI

struct MovieBackdropCarouselView: View {
    
    @ObservedObject var movieListService = MovieListService()
    @State var isPresenting = false
    
    let endpoint: MovieListEndpoint
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(endpoint.self.description)
                    .font(.system(size: 30, weight: .heavy))
                    .frame(alignment: .leading)
                    .padding(10)
                Button("Show All") {
                    isPresenting = true
                }
                .buttonStyle(.bordered)
                NavigationLink(destination: ShowAllView(movieArray: movieListService, endpoint: endpoint), isActive: $isPresenting) { EmptyView() }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(movieListService.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            MovieBackdropCard(movie: movie)
                        }.buttonStyle(PlainButtonStyle())
                            .onAppear {
                                if movie.id == movieListService.movies.last?.id {
                                    self.movieListService.loadNewPage(endpoint: endpoint)
                                }
                            }
                    }
                }
                .padding(20)
            }
        }
    }
}

//struct MovieBackdropCarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieBackdropCarouselView()
//    }
//}
