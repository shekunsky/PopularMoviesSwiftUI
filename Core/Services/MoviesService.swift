//
//  MoviesService.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

final class MoviesService: NSObject, MoviesUseCase {
    let network: Networking
    let database: FavoriteMoviesOperable
    
    private let imagesEndPoint: String
    private let thumbnailsEndPoint: String
    
    public init (context: Context,
                 environment: AppEnvironment) {
        network = context.networking
        database = context.database
        imagesEndPoint = environment.imagesURLAddress
        thumbnailsEndPoint = environment.thumbnailURLAddress
        
        super.init()
    }
    
    func getPopularMoviesList(for page: Int, completion: @escaping ([PopularMovie]?) -> Void) {
        network.get(for: page) { (result: PopularMoviesResult?) in
            let movies: [PopularMovie]? = result?.results
            completion(movies)
        }
    }

    func fullPathToImageFrom(path: String?) -> String? {
        guard let endPath = path else { return nil }
        return  "\(imagesEndPoint)\(endPath)"
    }
    
    func fullPathToThumbnailFrom(path: String?) -> String? {
        guard let endPath = path else { return nil }
        return  "\(thumbnailsEndPoint)\(endPath)"
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
