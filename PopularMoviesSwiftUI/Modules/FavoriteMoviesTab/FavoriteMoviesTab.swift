//
//  FavoriteMoviesTab.swift
//  PopularMoviesSwiftUI
//
//  Created by Alex2 on 17.08.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct FavoriteMoviesTab: View {
    
    @ObservedObject var model: FavoriteMoviesViewModel
    
    var body: some View {
        List {
            ForEach(model.popularMovies, id: \.id) { movie in
                
                PopularMovieTableRow(posterPath: self.model.fullPathToThumbnailFrom(path: movie.poster_path),
                                     title: movie.title,
                                     description: movie.overview,
                                     isFavorite: self.model.checkIsFavoriteMovie(id: movie.id ?? 0),
                                     isPreloading: false) {
                                        // FavoriteAction
                                        self.model.favoriteActionWith(movie: movie)
                                        
                }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
        }.onAppear() {
            UITableView.appearance().separatorStyle = .none
            self.model.getPopularMovies()
        }
    }
}


struct FavoriteMoviesTab_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesTab(model: FavoriteMoviesViewModel())
    }
}
