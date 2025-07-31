//
//  MovieViewModel.swift
//  KroeanMoviesAPI
//
//  Created by Victor Zerefos on 16/07/25.
//

import Foundation
import SwiftUI

@Observable
class MovieViewModel: ObservableObject {
    
    var movies: [Movie] = []
    
    func fetchMovies() async {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=f660e67eb65a91b641537516c836f45a&with_original_language=ko") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let movieResponse = try JSONDecoder().decode(Response.self, from: data)
            movies = movieResponse.results
        } catch  {
            print("Error fetching movies: \(error.localizedDescription)")
        }
    }
}
