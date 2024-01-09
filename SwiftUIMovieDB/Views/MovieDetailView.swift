//
//  MovieDetailView.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 8.08.2023.
//

import SwiftUI

struct MovieDetailView: View {
    
    var movieId: Int
    @State var text: String = ""
    @State var showAlert = false
    @ObservedObject var viewModel = MovieDetailViewModel()
    
    var body: some View {
        
        let (hour,minute) = viewModel.minutesToHoursMinutes(viewModel.selectedMovie?.runtime ?? 0)
        
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                
                // Image
                
                if let backdropPath = viewModel.selectedMovie?.backdrop_path {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(16/9, contentMode: .fit)
                        } else if phase.error != nil {
                            Text("There was an error loading the image.")
                                .frame(width: 300, height: 200)
                                .background(Color.black.opacity(0.4))
                                .frame(maxWidth: .infinity)
                        } else {
                            ProgressView()
                                .frame(width: 300, height: 200)
                                .frame(maxWidth: .infinity)
                        }
                    }
                } else {
                    Text("No Image.")
                        .frame(width: 300, height: 200)
                        .foregroundColor(Color.black.opacity(0.9))
                        .background(Color.black.opacity(0.4))
                        .frame(maxWidth: .infinity)
                        .task {
                            await viewModel.sleepHalfSecond()
                        }
                }
                
                // Genre - Year - Runtime
                
                HStack() {
                    Text(viewModel.selectedMovie?.genres.first?.name ?? "N/A")
                        .font(.system(size: 20, weight: .light))
                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0))
                    Text("·")
                        .font(.system(size: 20, weight: .light))
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    Text(viewModel.selectedMovie?.release_date?.substring(from: 0, to: 3) ?? "N/A")
                        .font(.system(size: 20, weight: .light))
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    Text("·")
                        .font(.system(size: 20, weight: .light))
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    Text("\(hour)h \(minute)m")
                        .font(.system(size: 20, weight: .light))
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
                
                Divider()
                
                // Overview
                
                Text(viewModel.selectedMovie?.overview ?? "Overview: N/A")
                    .font(.system(size: 20, weight: .light))
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
                
                Divider()
                
                // Vote Average
                
                Text("Rating :  \(String(format: "%.01f", viewModel.selectedMovie?.vote_average ?? 0.0))⭐")
                    .font(.system(size: 20, weight: .light))
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0))
                
                Divider()
                
                // Vote Count
                
                Text("Votes :  \(viewModel.selectedMovie?.vote_count ?? 0)")
                    .font(.system(size: 20, weight: .light))
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0))
                
                Divider()
                
                // Release Date
                
                Text("Release Date : \(viewModel.selectedMovie?.release_date ?? "N/A")")
                    .font(.system(size: 20, weight: .light))
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0))
                
            }
            .navigationTitle(viewModel.selectedMovie?.title ?? "")
        }
        .background(Color.gray.opacity(0.3))
        .onAppear {
            Task(priority: .medium) {
                try await self.viewModel.fetchMovieDetail(with: movieId)
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

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieId: 575264)
    }
}

extension String {
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from + 1)
        return String(self[start ..< end])
    }
}
