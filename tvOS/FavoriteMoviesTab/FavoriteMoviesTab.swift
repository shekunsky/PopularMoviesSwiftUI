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

struct FavoriteMoviesTab: View {
    
    @ObservedObject var model: FavoriteMoviesViewModel
    @State var selectedMovie: PopularMovie? = nil
    @State var showDetails: Bool = false
    @State private var tabBar: UITabBar! = nil
    
    /// Grid with 3 flexible columns
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVGrid(columns: columns, spacing: 100) {
                    ForEach(model.popularMovies, id: \.self) { movie in
                        NavigationLink(destination: DetailsScreenView(model: DetailsScreenViewModel(movieDetails: movie,
                                                                                                    isFavoriteMovie: model.checkIsFavoriteMovie(id: movie.id ?? 0),
                                                                                                    useCases: model.useCases,
                                                                                                    action: {
                                                                                                        model.favoriteActionWith(movie: movie)
                                                                                                    }))
                                        .onAppear { self.tabBar.isHidden = true } // to hide TabBar on detail screen
                                        .onDisappear { self.tabBar.isHidden = false } // to show TabBar back
                        ) {
                            PopularMovieTableRow(posterPath: model.fullPathToThumbnailFrom(path: movie.poster_path),
                                                 title: movie.title,
                                                 description: movie.overview,
                                                 isFavorite: Binding.constant(model.checkIsFavoriteMovie(id: movie.id ?? 0)) ,
                                                 isPreloading: false) {
                                /// No FavoriteAction in tvOS
                            }
                        }.buttonStyle(PlainButtonStyle())
                    }
                    .background(Color.systemBackground)
                }.padding(.top)
            }
            .onAppear() {
                model.getPopularMovies()
            }
        }.navigationBarHidden(true)
        .background(TabBarAccessor { tabbar in
            self.tabBar = tabbar
        })
        .padding(.top)
    }
}

#if DEBUG
struct FavoriteMoviesTab_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesTab(model: FavoriteMoviesViewModel())
    }
}
#endif
