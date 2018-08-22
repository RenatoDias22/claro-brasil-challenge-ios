//
//  HttpManager.swift
//  MoviesTv
//
//  Created by Renato Dias on 05/08/2018.
//  Copyright © 2018 Renato Dias. All rights reserved.
//

import Foundation
import JSONJoy
import SwiftHTTP
import SVProgressHUD
import Alamofire

class HttpManager {
    
    var moviesManager: [Movies] = [Movies]()
    
    init() { }
    
    func getSearchMovie(query : String) {

        let params = ["api_key": API_KEY, "language": LANGUAGE, "query": query]
        
        let url = BASE_URL + "search/movie"
        
        HTTP.GET(url, parameters: params) { response in
            
            if let error = response.error {
                print("got an error: \(error)")
                
            } else {
                
            }
            do {
                let resp = try MoviesData(JSONLoader(response.data))
                print("Resposta do JSON : \(resp)")
                
                if let array : [Movie] = resp.moviesArray {
                    
                    self.moviesManager.removeAll()
                    
                    for element in array {
                        let movie = Movies()
                        
                        if let id : Int = element.id {
                            movie.id = id
                        }
                        if let title : String = element.title {
                            movie.title = title
                        }
                        if let originalTitle : String = element.originalTitle {
                            movie.originalTitle = originalTitle
                        }
                        if let posterPath : String = element.posterPath {
                            movie.posterPath = posterPath
                        }
                        if let backdropPath : String = element.backdropPath {
                            movie.backdropPath = backdropPath
                        }
                        if let overview : String = element.overview {
                            movie.overview = overview
                        }
                        if let releaseDate : String = element.releaseDate {
                            movie.releaseDate = releaseDate
                        }
                        if let favorite : Bool = element.favorite {
                            movie.favorite = favorite
                        }
                        if let trailer : String = element.trailer {
                            movie.trailer = trailer
                        }
                        if let backdrops : [String] = element.backdrops {
                            movie.backdrops = backdrops
                        }
                        movie.setMoveis(movie: movie)
                        self.moviesManager.append(movie)
                    }
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setMovieObjectkey"), object: self.moviesManager)
                }
            } catch {
                print("unable to parse the JSON")
            }
            
            return
        }
    }
    
}
