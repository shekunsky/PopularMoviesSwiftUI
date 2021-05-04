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
    
    override var maxMoviesToDownload: Int { popularMovies.count }
    
    override func favoriteActionWith(movie: PopularMovie) {
        if useCases.movies.checkIsFavoriteMovie(id: movie.id ?? 0) {
            useCases.movies.deleteFromFavorites(movie: movie)
            setFavorite(state: false, for: movie.id)
        } else {
            useCases.movies.addToFavorites(movie: movie)
            setFavorite(state: true, for: movie.id)
        }
    }
    
    override func getPopularMovies() {
        let loadedMovies = useCases.movies.getFavoriteMovies()
        
        DispatchQueue.main.async { [weak self] in
            self?.popularMovies = loadedMovies
        }
    }
}
