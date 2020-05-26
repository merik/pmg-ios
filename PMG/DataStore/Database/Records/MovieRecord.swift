//
//  MovieRecord.swift
//  PMG
//
//  Created by Erik Mai on 26/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import GRDB

extension Movie: TableRecord {
    static let characters = hasMany(MovieCharactersRecord.self)
    
    var charactersQuery: QueryInterfaceRequest<MovieCharactersRecord> {
        return request(for: Movie.characters)
    }
    
    static var databaseTableName: String {
        return "movie"
    }
    
    enum Column: String, ColumnExpression {
        case episodeId, title, director, producer, openingCrawl, releaseDate
    }
}

extension Movie: FetchableRecord {
    convenience init(row: Row) {
        self.init()
        episodeId = row[Column.episodeId]
        title = row[Column.title]
        director = row[Column.director]
        producer = row[Column.producer]
        openingCrawl = row[Column.openingCrawl]
        releaseDate = row[Column.releaseDate]
    
    }
}

extension Movie: MutablePersistableRecord {
    func encode(to container: inout PersistenceContainer) {
        container[Column.episodeId] = episodeId
        container[Column.title] = title
        container[Column.director] = director
        container[Column.producer] = producer
        container[Column.openingCrawl] = openingCrawl
        container[Column.releaseDate] = releaseDate
    }
}

