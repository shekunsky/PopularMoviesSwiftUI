//
//  Networking.swift
//  Core
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

public protocol Networking {
    func get<T: Decodable>(for page: Int, completion: @escaping (T?) -> Void)
    func fullPathToImageFrom(path: String?) -> String?
    func fullPathToThumbnailFrom(path: String?) -> String?
}
