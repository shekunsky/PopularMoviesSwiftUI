//
//  BaseViewModel.swift
//  PopularMoviesTestApp
//
//  Created by Alex2 on 11.05.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import SwiftUI
#if os(watchOS)
import Core_watchOS
#else
import Core
#endif
import Combine

protocol PopularMoviesOperable {
    func getPopularMovies()
    func checkIsFavoriteMovie(id: Int) -> Bool
    func fullPathToThumbnailFrom(path: String?) -> String?
    var popularMovies: [PopularMovie] { get set }
    var moviesForCurrentPage: [PopularMovie]? { get set }
    var actionForDetailsScreen: (()->())? { get set }
    var maxMoviesToDownload: Int { get }
}

class BaseViewModel: ViewModel, PopularMoviesOperable, UseCasesConsumer {
    typealias UseCases = HasMoviesUseCase
    
    //MARK: - Vars
    let objectWillChange = ObservableObjectPublisher()
    var isFetchInProgress = false
    var currentPage: Int = 0
    @Published var popularMovies: [PopularMovie] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    var moviesForCurrentPage: [PopularMovie]? {
        didSet {
            popularMovies.append(contentsOf: moviesForCurrentPage ?? [])
            objectWillChange.send()
        }
    }

    var actionForDetailsScreen: (()->())?
    var maxMoviesToDownload: Int { 0 }
    
    convenience init(useCases: UseCases) {
        self.init()
        self.useCases = useCases
    }
    
    func getPopularMovies() { }
    func favoriteActionWith(movie: PopularMovie) { }
    
    func checkIsFavoriteMovie(id: Int) -> Bool {
        useCases.movies.checkIsFavoriteMovie(id: id)
    }
    
    func fullPathToThumbnailFrom(path: String?) -> String? {
        useCases.movies.fullPathToThumbnailFrom(path: path)
    }
    
    func setFavorite(state: Bool, for movieId: Int?) {
        for (index, _) in popularMovies.enumerated() {
            if popularMovies[index].id == movieId {
                if popularMovies[index].isFavorite == nil {
                    popularMovies[index].isFavorite = true
                } else {
                    popularMovies[index].isFavorite?.toggle()
                }
            }
        }
    }
}
