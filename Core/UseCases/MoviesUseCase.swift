//
//  MoviesUseCase.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

public protocol MoviesUseCase: AutoUseCaseProvider {
    //Network
    func getPopularMoviesList(for page: Int, completion: @escaping ([PopularMovie]?) -> Void)
    func fullPathToImageFrom(path: String?) -> String?
    func fullPathToThumbnailFrom(path: String?) -> String?
    
    //Database
    func checkIsFavoriteMovie(id: Int) -> Bool
    func addToFavorites(movie: PopularMovie)
    func deleteFromFavorites(movie: PopularMovie)
    func getFavoriteMovies() -> [PopularMovie]
    func numberOfFavoriteMovies() -> Int
}
