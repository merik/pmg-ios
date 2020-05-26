//
//  DatabaseRepository.swift
//  PMG
//
//  Created by Erik Mai on 26/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation

import GRDB

class DatabaseRepository {
    
    class func getMovies() -> [Movie]? {
        guard let dbQueue = PMGDatabase.shared.dbQueue else {
            return nil
        }
        do {
            let movies = try dbQueue.read { db -> [Movie] in
                let movies = try Movie.fetchAll(db)
                let moviesWithCharacters = try movies.map { movie -> Movie in
                    let characters = try movie.charactersQuery.fetchAll(db)
                    movie.characters = characters.map { character -> MovieCharacter in
                        return MovieCharacter(url: character.characterUrl)
                    }
                    return movie
                }
                return moviesWithCharacters
            }
            return movies
        } catch let error {
            // TODO: handle error
            return nil
        }
    }
    
    class func saveMovies(_ movies: [Movie]) {
        guard let dbQueue = PMGDatabase.shared.dbQueue else {
            return
        }
        do {
            try dbQueue.inTransaction { db in
                for var movie in movies {
                    try movie.insert(db)
                    for var character in movie.characters {
                        try character.save(db)
                        var characterRecord = MovieCharactersRecord(episodeId: movie.episodeId, characterUrl: character.url)
                        try characterRecord.save(db)
                    }
                    
                }
                return .commit
            }
        } catch let error {
            print(error)
        }
    }
    
    class func getMovieCharacter(with url: String) -> MovieCharacter? {
        guard let dbQueue = PMGDatabase.shared.dbQueue else {
            return nil
        }
        
        let character = try? dbQueue.read { db in
            try MovieCharacter.filter(Column(MovieCharacter.Column.url.rawValue) == url).fetchOne(db)
        }
        
        return character
    }
    
    class func saveMovieCharacter(_ character: MovieCharacter) {
        guard let dbQueue = PMGDatabase.shared.dbQueue else {
            return
        }
        
        var characterToDb = character   // need to be mutable to save to database
        do {
            try dbQueue.write { db in
                try characterToDb.insert(db)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
