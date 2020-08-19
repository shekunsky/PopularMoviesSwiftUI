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
        List {
            ForEach(model.popularMovies, id: \.id) { movie in
                
                PopularMovieTableRow(posterPath: self.fullPathToThumbnailFrom(path: movie.poster_path),
                                     title: movie.title,
                                     description: movie.overview, isFavorite: false, isPreloading: false) {
                                        
                }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
        }.onAppear() {
            UITableView.appearance().separatorStyle = .none
            self.model.getPopularMovies()
        }
    }
    
    func fullPathToThumbnailFrom(path: String?) -> String? {
        guard let endPath = path else { return nil }
        return  "https://image.tmdb.org/t/p/w200\(endPath)"
    }
}

struct PopularMoviesTab_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesTab(model: PopularMoviesViewModel())
    }
}
