//
//  PopularMoviesTab.swift
//  PopularMoviesSwiftUI
//
//  Created by Alex2 on 17.08.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import SwiftUI
import Combine
import Core

struct PopularMoviesTab: View {
    
    @ObservedObject var model: PopularMoviesViewModel
        
    var body: some View {
        NavigationView {
            List {
                ForEach(model.popularMovies, id: \.id) { movie in
                    NavigationLink(destination: DetailsScreenView(model: DetailsScreenViewModel(movieDetails: movie,
                                                                                                isFavoriteMovie: self.model.checkIsFavoriteMovie(id: movie.id ?? 0),
                                                                                                useCases: self.model.useCases,
                                                                                                coordinator: self.model.coordinator!, action: {
                                                                                                    self.model.favoriteActionWith(movie: movie)
                                                                                                    
                    }))) {
                        PopularMovieTableRow(posterPath: self.model.fullPathToThumbnailFrom(path: movie.poster_path),
                                             title: movie.title,
                                             description: movie.overview,
                                             isFavorite: self.model.checkIsFavoriteMovie(id: movie.id ?? 0),
                                             isPreloading: false) {
                                                // FavoriteAction
                                                self.model.favoriteActionWith(movie: movie)
                        }
                    }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                
                }
                // Preloading
                PopularMovieTableRow(posterPath: nil, title: nil, description: nil, isFavorite: false, isPreloading: true, favoriteAction: nil).onAppear {
                    // Load next page
                    self.model.getPopularMovies()
                }
            }.onAppear() {
                UITableView.appearance().separatorStyle = .none
                self.model.getPopularMovies()
            }
        }
    }
}

struct PopularMoviesTab_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesTab(model: PopularMoviesViewModel())
    }
}
