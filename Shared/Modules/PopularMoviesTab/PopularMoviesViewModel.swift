//
//  PopularMoviesViewModel.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Core
import SwiftUI
import Combine

final class PopularMoviesViewModel: BaseViewModel, ObservableObject {
            
    override var maxMoviesToDownload: Int { 10000 }
    
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
        guard !isFetchInProgress else { return }

        isFetchInProgress = true
        currentPage += 1
        useCases.movies.getPopularMoviesList(for: currentPage) { [weak self] (result) in
            
            guard let loadedMovies = result else {
                DispatchQueue.main.async {
                    self?.isFetchInProgress = false
                    self?.currentPage -= 1
                }
                return
            }
            DispatchQueue.main.async {
                self?.moviesForCurrentPage = loadedMovies
                self?.isFetchInProgress = false
            }
        }
    }
}
