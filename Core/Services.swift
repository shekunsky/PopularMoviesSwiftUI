//
//  ServicesConfiguration.swift
//  Base-Project
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation

final public class Services: UseCasesProvider, ObservableObject {
    
    private let context: Context
    private let environment: AppEnvironment

    // Services
    private lazy var moviesService = MoviesService(context: context, environment: environment)

    // Services Gateways
    public var movies: MoviesUseCase { return moviesService }

    public init(environment: AppEnvironment) {
        self.environment = environment
        
        Services.setupServices(environment: environment)
        let network = Network(environment: environment)
        let database = Database(configuration: .defaultConfiguration)
        self.context = Context(environment: environment,
                               networking: network,
                               database: database)
    }
}
