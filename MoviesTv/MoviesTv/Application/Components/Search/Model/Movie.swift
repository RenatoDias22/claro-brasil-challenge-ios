//
//  Movie.swift
//  MoviesTv
//
//  Created by Renato Dias on 05/08/2018.
//  Copyright © 2018 Renato Dias. All rights reserved.
//

import Foundation
import JSONJoy
import DeviceKit

struct MoviesData : JSONJoy {
    var moviesArray: [Movie] = [Movie]();
    init() { }
    init(_ decoder: JSONLoader) throws {
        if let movie = decoder["results"].getOptionalArray() {
            moviesArray = [Movie]()
            print(movie)
            
            for moviesDecoder in movie {
                print(moviesDecoder)
                do {
                    try moviesArray.append(Movie(moviesDecoder))
                }catch {
                    print("erro")
                }
            }
        }
    }
}

struct Movie: JSONJoy {

    var id = 0
    var title: String?
    var originalTitle: String?
    var posterPath: String?
    var backdropPath: String?
    var overview: String?
    var releaseDate: String?
    var favorite: Bool = false
    var trailer: String?
    var backdrops: [String] = [String]()
    
    init(_ decoder: JSONLoader) throws {
        id = try decoder["id"].get()
        title = try decoder["title"].get()
        originalTitle = try decoder["original_title"].get()
        posterPath = try decoder["poster_path"].get()
        backdropPath = try decoder["backdrop_path"].get()
        overview = try decoder["overview"].get()
        releaseDate = try decoder["release_date"].get()
        
    }

    init() { }

}


