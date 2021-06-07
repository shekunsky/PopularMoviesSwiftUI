//
//  Network.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Alamofire

final class Network: Networking {
    
    private let apiEndPoint: String
    
    init(apiEndPoint: String) {
        self.apiEndPoint = apiEndPoint
    }
    
    func get<T: Decodable>(for page: Int, completion: @escaping (T?) -> Void) {
        let absolutePath = "\(apiEndPoint)\(page)"
        AF.request(absolutePath).validate().responseDecodable(of: T.self) { (response) in
            guard let result = response.value else {
                completion(nil)
                return
            }
            completion(result)
        }
    }
}
