//
//  PopularMoviesSwiftUIApp.swift
//  Shared
//
//  Created by Alex2 on 02.05.2021.
//

import SwiftUI
import Core

@main
struct PopularMoviesSwiftUIApp: App {
    var useCases = Services(environment: AppEnvironment.development(.normal))
    
    var body: some Scene {
        WindowGroup {
            AppView().environmentObject(useCases)
        }
    }
}
