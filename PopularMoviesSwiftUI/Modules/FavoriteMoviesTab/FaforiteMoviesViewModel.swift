//
//  FavoriteMoviesViewModel.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Core
import SwiftUI

final class FavoriteMoviesViewModel: BaseViewModel, ObservableObject {
    @Published var needToRefresh: Bool = false
    
    override var maxMoviesToDownload: Int { popularMovies.count }
    
    override func favoriteActionWith(movie: PopularMovie) {
        if useCases.movies.checkIsFavoriteMovie(id: movie.id ?? 0) {
            setFavorite(state: false, for: movie.id)
            useCases.movies.deleteFromFavorites(movie: movie)
            if let index = popularMovies.firstIndex(where: { $0.id == movie.id }) {
                popularMovies.remove(at: index)
            }
        } else {
            useCases.movies.addToFavorites(movie: movie)
            setFavorite(state: true, for: movie.id)
        }
        needToRefresh.toggle()
    }
    
    override func getPopularMovies() {
        let loadedMovies = useCases.movies.getFavoriteMovies()
        
        DispatchQueue.main.async { [weak self] in
            self?.popularMovies = loadedMovies
        }
    }
}
