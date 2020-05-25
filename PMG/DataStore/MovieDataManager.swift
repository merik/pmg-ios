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
    
    func getMovies() -> Observable<[Movie]> {
        return apiRepository.getMovieList()
    }
    
    func getMovieCharacter(from url: String) -> Observable<MovieCharacter> {
        return apiRepository.getCharacter(from: url)
    }
}
