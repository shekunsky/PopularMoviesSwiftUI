//
//  AppView.swift
//  PopularMoviesSwiftUI
//
//  Created by Alex2 on 17.08.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import SwiftUI

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            PopularMoviesTab()
                .tabItem {
                    Image(systemName: "video.fill")
                    Text("Popular")
                }

            FavoriteMoviesTab()
                .tabItem {
                    Image(systemName: "star.fill")
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
