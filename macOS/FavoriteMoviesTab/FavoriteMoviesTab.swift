//
//  FavoriteMoviesTab.swift
//  PopularMoviesSwiftUI
//
//  Created by Alex2 on 17.08.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import Core
import Combine

struct FavoriteMoviesTab: View {
    
    @ObservedObject var model: FavoriteMoviesViewModel
    @State private var selectedMovie: PopularMovie? = nil
    
    var body: some View {
        List(selection: $selectedMovie) {
            ForEach(model.popularMovies, id: \.self) { movie in
                NavigationLink(
                    destination: DetailsScreenView(
                        model: DetailsScreenViewModel(
                            movieDetails: movie,
                            isFavoriteMovie: model.checkIsFavoriteMovie(id: movie.id ?? 0),
                            useCases: model.useCases,
                            action: {
                                model.favoriteActionWith(movie: movie)
                                model.getPopularMovies()
                            }),
                        isFavorite: model.checkIsFavoriteMovie(id: movie.id ?? 0))
                ) {
                    PopularMovieTableRow(
                        posterPath: model.fullPathToThumbnailFrom(path: movie.poster_path),
                        title: movie.title,
                        description: movie.overview,
                        isFavorite: Binding.constant(model.checkIsFavoriteMovie(id: movie.id ?? 0)) ,
                        isPreloading: false) {
                            // FavoriteAction
                            model.favoriteActionWith(movie: movie)
                            model.getPopularMovies()
                        }
                }
                .tag(movie)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            .listRowInsets(EdgeInsets())
            .background(Color.clear)
        }
        .navigationTitle("Favorites")
        .frame(minWidth: 400)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        .listRowInsets(EdgeInsets())
        .background(Color.clear)
        .onAppear() {
            model.getPopularMovies()
        }
    }
}

#if DEBUG
struct FavoriteMoviesTab_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesTab(model: FavoriteMoviesViewModel())
    }
}
#endif
