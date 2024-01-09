//
//  MovieListView.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 21.08.2023.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var moviesNowPlaying = MovieListService()
    @ObservedObject private var moviesUpcoming = MovieListService()
    @ObservedObject private var moviesTopRated = MovieListService()
    @ObservedObject private var moviesPopular = MovieListService()
    
    @State var showAlert = false
    
    var body: some View {
        
        var alertError: Error?
        
        ScrollView(.vertical) {
            
            // Now Playing
            MoviePosterCarouselView(movieListService: moviesNowPlaying, endpoint: .nowPlaying)
            
            // Upcoming
            MovieBackdropCarouselView(movieListService: moviesUpcoming, endpoint: .upcoming)
            
            // Top Rated
            MovieBackdropCarouselView(movieListService: moviesTopRated, endpoint: .topRated)
            
            // Popular
            MovieBackdropCarouselView(movieListService: moviesPopular, endpoint: .popular)
        }
        .refreshable {
            self.moviesNowPlaying.handleRefresh(endpoint: .nowPlaying)
            self.moviesUpcoming.handleRefresh(endpoint: .upcoming)
            self.moviesTopRated.handleRefresh(endpoint: .topRated)
            self.moviesPopular.handleRefresh(endpoint: .popular)
        }
        
        .onAppear {
            self.moviesNowPlaying.loadData(with: .nowPlaying)
            self.moviesUpcoming.loadData(with: .upcoming)
            self.moviesTopRated.loadData(with: .topRated)
            self.moviesPopular.loadData(with: .popular)
        }
        .onReceive(moviesNowPlaying.$error, perform: { error in
            if error != nil {
                showAlert.toggle()
                alertError = error
            }
        })
        .onReceive(moviesUpcoming.$error, perform: { error in
            if error != nil {
                showAlert.toggle()
            }
        })
        .onReceive(moviesTopRated.$error, perform: { error in
            if error != nil {
                showAlert.toggle()
            }
        })
        .onReceive(moviesPopular.$error, perform: { error in
            if error != nil {
                showAlert.toggle()
            }
        })
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error"), message: Text(alertError?.localizedDescription ?? ""))
        })
        .background(Color.gray.opacity(0.5))
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
