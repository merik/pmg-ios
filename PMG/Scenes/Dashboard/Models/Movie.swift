//
//  Movie.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie {
    
    var episodeId = 0
    var title = ""
    var director = ""
    var producer = ""
    var openingCrawl = ""
    var releaseDate = ""
    var characters: [MovieCharacter] = []
    
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
}
