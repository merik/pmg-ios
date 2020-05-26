//
//  MovieCharactersRecord.swift
//  PMG
//
//  Created by Erik Mai on 26/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import GRDB

struct MovieCharactersRecord {
    var episodeId: Int
    var characterUrl: String
    
    // FIX ME: should figure out how GRDB use 2 fields as primary key
    // Kind of a hack here
    var id: String {
        return "\(episodeId)_\(characterUrl)"
    }
}

extension MovieCharactersRecord: TableRecord {
    
    static let movie = belongsTo(Movie.self)
    
    static var databaseTableName: String {
        return "movieCharacters"
    }
    
    enum Column: String, ColumnExpression {
        case id, episodeId, characterUrl
    }
}

extension MovieCharactersRecord: FetchableRecord {
    init(row: Row) {
        episodeId = row[Column.episodeId]
        characterUrl = row[Column.characterUrl]
    }
}

extension MovieCharactersRecord: MutablePersistableRecord {
    func encode(to container: inout PersistenceContainer) {
        container[Column.id] = id
        container[Column.episodeId] = episodeId
        container[Column.characterUrl] = characterUrl
    }
    
}
