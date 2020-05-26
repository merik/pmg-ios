//
//  Movie.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import SwiftyJSON

final class Movie: Comparable {
    static func < (lhs: Movie, rhs: Movie) -> Bool {
        guard let lhsDate = lhs.movieDate else {
            return true
        }
        
        guard let rhsDate = rhs.movieDate else {
            return false
        }
        
        return lhsDate < rhsDate
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        guard let lhsDate = lhs.movieDate else {
            return false
        }
        
        guard let rhsDate = rhs.movieDate else {
            return false
        }
        
        return Calendar.current.isDate(lhsDate, inSameDayAs: rhsDate)
    }
    
    // Todo: Sort movies by releaseDate
    var episodeId = 0
    var title = ""
    var director = ""
    var producer = ""
    var openingCrawl = ""
    var releaseDate = ""
    var characters: [MovieCharacter] = []
    
    init() {
        
    }
    
    init?(json: JSON) {
        guard let id = json["episode_id"].int else {
            return nil
        }
        
        self.episodeId = id
        self.title = json["title"].stringValue
        self.director = json["director"].stringValue
        self.producer = json["producer"].stringValue
        self.openingCrawl = json["opening_crawl"].stringValue
        self.releaseDate = json["release_date"].stringValue
        if let characterUrls = json["characters"].arrayObject as? [String] {
            for url in characterUrls {
                let character = MovieCharacter(url: url)
                self.characters.append(character)
            }
        }
    }
    
    var movieDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.date(from: self.releaseDate)
    }
}
