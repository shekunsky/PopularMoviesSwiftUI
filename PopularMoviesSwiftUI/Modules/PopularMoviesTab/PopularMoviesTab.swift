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
    @State var selectedMovie: PopularMovie? = nil
    @State var showDetails: Bool = false
    @State var needRefresh: Bool = false
    
    var body: some View {
        List {
            ForEach(model.popularMovies, id: \.self) { movie in
                PopularMovieTableRow(posterPath: model.fullPathToThumbnailFrom(path: movie.poster_path),
                                     title: movie.title,
                                     description: movie.overview,
                                     isFavorite: model.checkIsFavoriteMovie(id: movie.id ?? 0),
                                     isPreloading: false) {
                                        // FavoriteAction
                                        model.favoriteActionWith(movie: movie)
                }.onTapGesture {
                    selectedMovie = movie
                    showDetails.toggle()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            .listRowInsets(EdgeInsets())
            .background(Color.systemBackground)
            
            // Preloading
            PopularMovieTableRow(posterPath: nil, title: nil, description: nil, isFavorite: false, isPreloading: true, favoriteAction: nil).onAppear {
                // Load next page
                self.model.getPopularMovies()
            }
        }.onAppear() {
            UITableView.appearance().separatorStyle = .none
            self.model.getPopularMovies()
        }.sheet(item: $selectedMovie) { item in
            DetailsScreenView(model: DetailsScreenViewModel(movieDetails: item,
                                                            isFavoriteMovie: model.checkIsFavoriteMovie(id: selectedMovie?.id ?? 0),
                                                            useCases: model.useCases,
                                                            action: {
                                                                model.favoriteActionWith(movie: item)
                                                                
            }), needRefresh: self.$needRefresh)
        }.padding(.top)
    }
}

struct PopularMoviesTab_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesTab(model: PopularMoviesViewModel())
    }
}
