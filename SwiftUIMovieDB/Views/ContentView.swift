//
//  ContentView.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 3.08.2023.
//


import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView() {
            NavigationView {
                MovieListView()
                    .navigationTitle("The MovieDB")
            }
            .navigationViewStyle(.stack)
            .tabItem {
                VStack {
                    Image(systemName: "tv")
                    Text("Movies")
                }
            }
            .tag(0)
            NavigationView {
                MovieSearchView()
                    .navigationTitle("Searching")
            }
            .navigationViewStyle(.stack)
            .tabItem {
                VStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            }
            .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
