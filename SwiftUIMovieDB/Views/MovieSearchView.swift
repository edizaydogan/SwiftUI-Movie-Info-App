//
//  MovieSearchView.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 10.08.2023.
//

import SwiftUI

struct MovieSearchView: View {
    
    @State private var searchText = ""
    @State var showAlert = false
    @ObservedObject var viewModel = MovieSearchViewModel()
    
    var body: some View {
        
        let searchedMovies = viewModel.searchedMovies
        
        List(searchedMovies.filter { $0.title.localizedCaseInsensitiveContains(searchText)}, id: \.self) { movie in
            NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                Text(movie.title)
            }
        }
        .searchable(text: $searchText, prompt: "Look for something")
        .disableAutocorrection(true)
        .onChange(of: searchText) { value in
            Task(priority: .medium) {
                try await self.viewModel.searchMovie(query: searchText)
            }
        }
        .onReceive(viewModel.$error, perform: { error in
            if error != nil {
                showAlert.toggle()
            }
        })
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? ""))
        })
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
