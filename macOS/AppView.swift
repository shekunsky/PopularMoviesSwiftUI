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
    @State var selection: NavigationItem? = .all
    
    var sideBar: some View {
        List(selection: $selection) {
            NavigationLink(
                destination: PopularMoviesTab(model: PopularMoviesViewModel(useCases: useCases)),
                tag: NavigationItem.all,
                selection: $selection
            ) {
                Label("Popular", systemImage: "video.fill")
            }
            .tag(NavigationItem.all)
            NavigationLink(
                destination: FavoriteMoviesTab(model: FavoriteMoviesViewModel(useCases: useCases)),
                tag: NavigationItem.favorites,
                selection: $selection
            ) {
                Label("Favorites", systemImage: "star.fill")
            }
            .tag(NavigationItem.favorites)
        }
        .frame(minWidth: 150)
        .listStyle(SidebarListStyle())
        .toolbar {
            ToolbarItem {
                Button(action: toggleSideBar) {
                    Label("Toggle Sidebar", systemImage: "sidebar.left")
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            sideBar
            Text("Select a category")
                .foregroundColor(.secondary)
            Text("Select a movie")
                .foregroundColor(.secondary)
        }
    }
    
    func toggleSideBar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(
            #selector(NSSplitViewController.toggleSidebar),
            with: nil)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
