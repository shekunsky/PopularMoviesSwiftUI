//
//  DetailsScreenViewModel.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 22.05.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

#if os(watchOS)
import Core_watchOS
#else
import Core
#endif
import SwiftUI

protocol MovieDetailsOperable {
    var movieDetails: PopularMovie { get set }
    var isFavoriteMovie: Bool { get }
    var posterPath: String? { get }
    func makeActionOnMovie()
}

class DetailsScreenViewModel: BaseViewModel, MovieDetailsOperable, ObservableObject {
    var movieDetails: PopularMovie
    var isFavoriteMovie: Bool
    var posterPath: String? {
        useCases.movies.fullPathToImageFrom(path: movieDetails.poster_path)
    }
    
    init(movieDetails: PopularMovie, isFavoriteMovie: Bool, useCases: UseCases, action:  (()->Void)?) {
        self.movieDetails = movieDetails
        self.isFavoriteMovie = isFavoriteMovie
        super.init()
        self.useCases = useCases
        self.actionForDetailsScreen = action
    }
    
    func makeActionOnMovie() {
        actionForDetailsScreen?()
    }
}
