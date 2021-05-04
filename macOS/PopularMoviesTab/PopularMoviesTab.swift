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
    @State private var selectedMovie: PopularMovie? = nil
    
    var body: some View {
        List(selection: $selectedMovie) {
            ForEach(model.popularMovies, id: \.self) { movie in
                NavigationLink(
                    destination: DetailsScreenView(model: DetailsScreenViewModel(movieDetails: movie,
                                                                                 isFavoriteMovie: model.checkIsFavoriteMovie(id: movie.id ?? 0),
                                                                                 useCases: model.useCases,
                                                                                 action: {
                                                                                    model.favoriteActionWith(movie: movie)
                                                                                 })),
                    tag: movie,
                    selection: $selectedMovie
                ) {
                    PopularMovieTableRow(posterPath: model.fullPathToThumbnailFrom(path: movie.poster_path),
                                         title: movie.title,
                                         description: movie.overview,
                                         isFavorite: Binding.constant(model.checkIsFavoriteMovie(id: movie.id ?? 0)) ,
                                         isPreloading: false) {
                        // FavoriteAction
                        model.favoriteActionWith(movie: movie)
                    }
                }
                .tag(movie)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            .listRowInsets(EdgeInsets())
            .background(Color.clear)
            // Preloading
            PopularMovieTableRow(posterPath: nil, title: nil, description: nil, isFavorite: Binding.constant(false), isPreloading: true, favoriteAction: nil).onAppear {
                // Load next page
                model.getPopularMovies()
            }
        }
        .navigationTitle("Movies")
        .frame(minWidth: 400)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        .listRowInsets(EdgeInsets())
        .background(Color.clear)
        .onAppear() {
            model.getPopularMovies()
        }
    }
}

struct PopularMoviesTab_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesTab(model: PopularMoviesViewModel())
    }
}
