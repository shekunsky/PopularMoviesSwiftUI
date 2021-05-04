//
//  ContentView.swift
//  PopularMoviesSwiftUI (macOS)
//
//  Created by Alex2 on 03.05.2021.
//

import SwiftUI
import Core

enum NavigationItem {
  case all
  case favorites
}

struct ContentView: View {
    var useCases = Services(environment: AppEnvironment.development(.normal))
    var body: some View {
        AppView().environmentObject(useCases)
    }
}
