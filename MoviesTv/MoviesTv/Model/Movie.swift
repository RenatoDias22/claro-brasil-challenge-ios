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

class Movies {
    
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
    
    var titleText: String?
    var posterURL: URL?
    var backdropURL: URL?
    var overviewText: String?
    var trailerURL: URL?
    var trailerThumbnail: URL?
    
    init() {
        
    }
  
    init(id: Int!, title: String?, originalTitle: String?, posterPath: String?, backdropPath: String?, overview: String?, releaseDate: String?, favorite: Bool?, trailer: String?, backdrops: [String]) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.favorite = favorite!
        self.trailer = trailer
        self.backdrops = backdrops
        
    }
    
    func setMoveis(movie: Movies){
        
        if let posterPath = movie.posterPath {
            self.posterURL = URL(string: "\(IMG_BASE_URL)\(Movies.posterWidthPath())\(posterPath)")
        }else {
            self.posterURL = nil
        }
        
        if let backdropPath = movie.backdropPath {
            self.backdropURL = URL(string: "\(IMG_BASE_URL)\(Movies.backdropWidthPath())\(backdropPath)")
        } else {
            self.backdropURL = nil
        }
        
        if let title = self.title, !title.isEmpty {
            titleText =  title
        }else{
            titleText = L10n.Erro.unavailable
        }
        
        if let overview = movie.overview, !overview.isEmpty {
            self.overviewText = overview
        } else {
            self.overviewText = L10n.Erro.unavailable
        }
        
        if let key = movie.trailer {
            self.trailerURL = URL(string: "\(YOUTUBE_BASE_URL)\(key)")
        } else {
            self.trailerURL = nil
        }
        
        if let key = movie.trailer {
            self.trailerThumbnail = URL(string: "\(YOUTUBE_THUMBNAIL_BASE_URL)\(key)/\(Movies.youtubeThumbnailQuality())")
        } else {
            self.trailerThumbnail = nil
        }
    }
    
    static func posterWidthPath() -> String {
        if currentDevice.isPad {
            return "w500"
        } else {
            return "w342"
        }
    }
    
    static func backdropWidthPath() -> String {
        if currentDevice.isPad {
            return "w780"
        } else {
            return "w300"
        }
    }
    
    static func youtubeThumbnailQuality() -> String {
        return "hqdefault.jpg"
    }
}

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


