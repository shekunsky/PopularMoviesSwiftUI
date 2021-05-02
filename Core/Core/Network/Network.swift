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
    private let imagesEndPoint: String
    private let thumbnailsEndPoint: String
    
    init(apiEndPoint: String,
         imagesEndPoint: String,
         thumbnailsEndPoint: String) {
        self.apiEndPoint = apiEndPoint
        self.imagesEndPoint = imagesEndPoint
        self.thumbnailsEndPoint = thumbnailsEndPoint
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
    
    func fullPathToImageFrom(path: String?) -> String? {
        guard let endPath = path else { return nil }
        return  "\(imagesEndPoint)\(endPath)"
    }
    
    func fullPathToThumbnailFrom(path: String?) -> String? {
        guard let endPath = path else { return nil }
        return  "\(thumbnailsEndPoint)\(endPath)"
    }
}
