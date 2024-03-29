//
//  PopularMovie.swift
//  Core
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation

public struct PopularMoviesResult: Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [PopularMovie]
}

public struct PopularMovie: Decodable, Identifiable, Hashable {
    public init(poster_path: String?, adult: Bool?, overview: String?, release_date: String?, genre_ids: [Int]?, id: Int?, original_title: String?, original_language: String?, title: String?, backdrop_path: String?, popularity: Float?, vote_count: Int?, video: Bool?, vote_average: Float?, isFavorite: Bool? = false) {
        self.poster_path = poster_path
        self.adult = adult
        self.overview = overview
        self.release_date = release_date
        self.genre_ids = genre_ids
        self.id = id
        self.original_title = original_title
        self.original_language = original_language
        self.title = title
        self.backdrop_path = backdrop_path
        self.popularity = popularity
        self.vote_count = vote_count
        self.video = video
        self.vote_average = vote_average
        self.isFavorite = isFavorite
    }
    
    public let poster_path: String?
    public let adult: Bool?
    public let overview: String?
    public let release_date: String?
    public let genre_ids: [Int]?
    public let id: Int?
    public let original_title: String?
    public let original_language: String?
    public let title: String?
    public let backdrop_path: String?
    public let popularity: Float?
    public let vote_count: Int?
    public let video: Bool?
    public let vote_average: Float?
    public var isFavorite: Bool?
}
