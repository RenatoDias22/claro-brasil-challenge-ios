//
//  Movies.swift
//  MoviesTv
//
//  Created by Renato Dias on 05/08/2018.
//  Copyright © 2018 Renato Dias. All rights reserved.
//

import Foundation

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
            self.posterURL = URL(string: "\(IMG_BASE_URL)\(self.posterWidthPath())\(posterPath)")
        }else {
            self.posterURL = nil
        }
        
        if let backdropPath = movie.backdropPath {
            self.backdropURL = URL(string: "\(IMG_BASE_URL)\(self.backdropWidthPath())\(backdropPath)")
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
            self.trailerThumbnail = URL(string: "\(YOUTUBE_THUMBNAIL_BASE_URL)\(key)/\(self.youtubeThumbnailQuality())")
        } else {
            self.trailerThumbnail = nil
        }
    }
    
    func posterWidthPath() -> String {
        if currentDevice.isPad {
            return "w500"
        } else {
            return "w342"
        }
    }
    
    func backdropWidthPath() -> String {
        if currentDevice.isPad {
            return "w780"
        } else {
            return "w300"
        }
    }
    
    func youtubeThumbnailQuality() -> String {
        return "hqdefault.jpg"
    }
}
