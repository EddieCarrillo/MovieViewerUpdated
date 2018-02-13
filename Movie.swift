//
//  Movie.swift
//  MovieViewer
//
//  Created by my mac on 9/26/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import Foundation

class Movie {
    
    
    
    var posterPath: String?
    var overview: String?
    var originalTitle: String?
    var popularity: Double?
    var releaseDate: String?
    var title: String?
    var voteAverage: Double?
    var voteCount: Double?
    var originalLanguage: String?
    var genreIds: [Int]?
    var genreIdsLoaded: [[String: Any]]?
    var backdropPath: String?
    //New vals
    var budget: Int?
    var homepage: String?
    var imdbId: String?
    var revenue: Int?
    var tagline: String?
    var runTime: Int?
    
    var id: Int?
    
    
    init(jsonMap: NSDictionary){
        
      // print("\n\n\n\n\n____jsonMap____\n\(jsonMap)\n____\n\n\n\n\n")
//        print ("average: \(jsonMap["vote_average"])")
        
        if let imdbId = jsonMap["imdb_id"] as? String {
            self.imdbId = imdbId
        }else {
            print("Could not extract imdb")
        }
        
        if let revenue = jsonMap["revenue"] as? Int {
            self.revenue = revenue
        }else {
            print("Could not extract revenue")
        }
        if let tagline = jsonMap["tagline"] as? String {
            self.tagline = tagline
        }else {
            print("Could not extract tagline.")
        }
        if let homepage = jsonMap["homepage"] as? String {
            self.homepage = homepage
        }else {
            print("Could not extract home page.")
        }
        if let budget = jsonMap["budget"] as? Int {
            self.budget = budget
        }else {
            print("Could not extract budget")
        }
        if let path = jsonMap["poster_path"] as? String {
            self.posterPath = path;
        }else {
            print("Could not extract post path from JSON")
        }
        if let backdrop = jsonMap["backdrop_path"] as? String {
            self.backdropPath = backdrop
        }else {
             print("Could not extract backdrop path from JSON")
        }
      //  print("[GENRE IDS] \(jsonMap["genre"])")
        if let genreIds = jsonMap["genre_ids"] as? [Int] {
            self.genreIds = genreIds
        }else if let genres = jsonMap["genres"] as? [[String: Any]]{
            self.genreIdsLoaded = genres
        }else {
            print("Could not extract genre ids  from JSON")

        }
      
        if let originalLang = jsonMap["original_language"] as? String {
            self.originalLanguage = originalLang
        }else {
            print("Could not extract original language  from JSON")
        }
        if let originalTitle = jsonMap["original_title"] as? String {
            self.originalTitle = originalTitle
        }else {
            print("Could not extract original title from JSON")
        }
        if let overview = jsonMap["overview"] as? String {
            self.overview = overview
        }else {
            print("Could not extract overview from JSON")
        }
        if let popularity = jsonMap["popularity"] as? Double {
            self.popularity = popularity
        }else {
            print("Could not extract popularity from JSON")
        }
        if let releaseDate = jsonMap["release_date"] as? String {
            self.releaseDate = releaseDate
        }else {
            print("Could not extract release date")
        }
        if let voteAverage = jsonMap["vote_average"] as? Double {
            self.voteAverage = voteAverage
        }else {
            print("Could not extract vote average.")
        }
        if let voteCount = jsonMap["vote_count"] as? Double  {
             self.voteCount = voteCount
        }else {
            print("Could not extact the vote count.")
        }
        if let title = jsonMap["title"] as? String {
            self.title = title
        }else {
           print("Could not extact the title.")
        }
        
        if let runtime = jsonMap["runtime"] as? Int {
           self.runTime = runtime
        }else {
           print("Could not extract the runtime.")
        }
        if let id = jsonMap["id"] as? Int {
            self.id = id
        }else {
            print("Could not extract id.")
        }
    }

    
    
}
