//
//  AppView.swift
//  PopularMoviesSwiftUI
//
//  Created by Alex2 on 17.08.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import SwiftUI
import Core
import Combine

struct AppView: View {
    @EnvironmentObject var useCases: Services
    
    var body: some View {
        TabView {
            PopularMoviesTab(model: PopularMoviesViewModel(useCases: useCases))
                .tabItem {
                    Image(systemName: "video.fill").font(.system(size: 22))
                    Text("Popular")
                }

            FavoriteMoviesTab(model: FavoriteMoviesViewModel(useCases: useCases))
                .tabItem {
                    Image(systemName: "star.fill").font(.system(size: 22))
                    Text("Favorite")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
