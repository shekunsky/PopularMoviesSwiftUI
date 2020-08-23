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
    @State private var showDetails: Bool = false
    @State var needRefresh: Bool = false
    
    var body: some View {
        List {
            ForEach(model.popularMovies, id: \.self) { movie in
                PopularMovieTableRow(posterPath: self.model.fullPathToThumbnailFrom(path: movie.poster_path),
                                     title: movie.title,
                                     description: movie.overview,
                                     isFavorite: self.model.checkIsFavoriteMovie(id: movie.id ?? 0),
                                     isPreloading: false) {
                                        // FavoriteAction
                                        self.model.favoriteActionWith(movie: movie)
                }.onTapGesture {
                    self.selectedMovie = movie
                    self.showDetails.toggle()
                }
            }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            
            // Preloading
            PopularMovieTableRow(posterPath: nil, title: nil, description: nil, isFavorite: false, isPreloading: true, favoriteAction: nil).onAppear {
                // Load next page
                self.model.getPopularMovies()
            }
        }.onAppear() {
            UITableView.appearance().separatorStyle = .none
            self.model.getPopularMovies()
        }.sheet(isPresented: $showDetails) {
            DetailsScreenView(model: DetailsScreenViewModel(movieDetails: self.selectedMovie!,
                                                            isFavoriteMovie: self.model.checkIsFavoriteMovie(id: self.selectedMovie?.id ?? 0),
                                                            useCases: self.model.useCases,
                                                            coordinator: self.model.coordinator!, action: {
                                                                self.model.favoriteActionWith(movie: self.selectedMovie!)
                                                                
            }), needRefresh: self.$needRefresh)
        }
    }
}

struct PopularMoviesTab_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesTab(model: PopularMoviesViewModel())
    }
}
