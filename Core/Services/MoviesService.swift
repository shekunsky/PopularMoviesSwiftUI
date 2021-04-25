//
//  MoviesService.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import UIKit

final class MoviesService: NSObject, MoviesUseCase {
    let network: Networking
    let database: FavoriteMoviesOperable
    
    public init (context: Context) {
        network = context.networking
        database = context.database
        super.init()
    }
    
    func getPopularMoviesList(for page: Int, completion: @escaping ([PopularMovie]?) -> Void) {
        network.get(for: page) { (result: PopularMoviesResult?) in
            let movies: [PopularMovie]? = result?.results
            completion(movies)
        }
    }

    func fullPathToImageFrom(path: String?) -> String? {
        network.fullPathToImageFrom(path: path)
    }
    
    func fullPathToThumbnailFrom(path: String?) -> String? {
        network.fullPathToThumbnailFrom(path: path)
    }
    
    func checkIsFavoriteMovie(id: Int) -> Bool {
        database .checkIsFavoriteMovie(id: id)
    }
    func addToFavorites(movie: PopularMovie) {
        database.addToFavorites(movie: movie)
    }
    func deleteFromFavorites(movie: PopularMovie) {
        database.deleteFromFavorites(movie: movie)
    }
    func getFavoriteMovies() -> [PopularMovie] {
        database.getFavoriteMovies()
    }
    func numberOfFavoriteMovies() -> Int {
        database.numberOfFavoriteMovies()
    }
}
