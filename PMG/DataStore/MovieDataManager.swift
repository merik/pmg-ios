//
//  MovieDataManager.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import RxSwift

class MovieDataManager {
    static let networkQueue = ConcurrentDispatchQueueScheduler.init(qos: .background)
    
    private var apiRepository: BaseRepository
       
    static let shared = MovieDataManager()
       
    init () {
        apiRepository = ApiRepository()
    }
    
    func changeRepository(repository: BaseRepository) {
        apiRepository = repository
    }
    
    func getMovies(from onlineOnly: Bool = false) -> Observable<[Movie]> {
        // Get data from local database (cache) first
        if !onlineOnly {
            if let movies = DatabaseRepository.getMovies(), !movies.isEmpty {
                return Observable.just(movies)
            }
        }
        // Data not in cache, get new one (and put in cache)
        return apiRepository.getMovieList()
    }
    
    func getMovieCharacter(from url: String) -> Observable<MovieCharacter> {
        
        if let character = DatabaseRepository.getMovieCharacter(with: url) {
            if character.valid {
                return Observable.just(character)
            }
        }
       
        return apiRepository.getCharacter(from: url)
    }
}
