//
//  ContentView.swift
//  KroeanMoviesAPI
//
//  Created by Victor Zerefos on 16/07/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.movies) { movie in
                    
                    HStack(alignment: .top) {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 60, height: 100)
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                            } else if phase.error != nil {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 60, height: 100)
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                ProgressView()
                            }
                            
                        }
                        Text(movie.title)
                            .font(.headline)
                            .lineLimit(1)
                            .fixedSize()
                            .padding(.leading, 8)
                            .foregroundStyle(.black)
                        Spacer()
                        
                        VStack{
                            Spacer()
                            Text(String(movie.release_date ?? ""))
                                .font(.system(size: 10))
                            Text(String(movie.vote_average ?? 0))
                            Spacer()
                        }
                    }
                }
                .navigationTitle("Korean Movies")
                .listStyle(.plain)
                
            }
            .task {
                await viewModel.fetchMovies()
            }
        } 
    }
}

#Preview {
    ContentView()
}
