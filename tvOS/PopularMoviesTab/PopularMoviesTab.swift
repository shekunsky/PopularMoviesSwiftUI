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
                    
                    // Preloading
                    PopularMovieTableRow(posterPath: nil, title: nil, description: nil, isFavorite: Binding.constant(false), isPreloading: true, favoriteAction: nil).onAppear {
                        // Load next page
                        model.getPopularMovies()
                    }
                }
            }
            .onAppear() {
                model.getPopularMovies()
            }
        }.navigationBarHidden(false)
        .background(TabBarAccessor { tabbar in
            self.tabBar = tabbar
        })
        .padding(.top)
    }
}


/// This need to have posibility hide TabBar on Details Screen
struct PopularMoviesTab_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesTab(model: PopularMoviesViewModel())
    }
}

struct TabBarAccessor: UIViewControllerRepresentable {
    var callback: (UITabBar) -> Void
    private let proxyController = ViewController()
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
    UIViewController {
        proxyController.callback = callback
        return proxyController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
    }
    
    typealias UIViewControllerType = UIViewController
    
    private class ViewController: UIViewController {
        var callback: (UITabBar) -> Void = { _ in }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let tabBar = self.tabBarController {
                self.callback(tabBar.tabBar)
            }
        }
    }
}
