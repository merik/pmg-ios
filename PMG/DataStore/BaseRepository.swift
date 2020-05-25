//
//  BaseRepository.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseRepository {
    func getMovieList() -> Observable<[Movie]>
    func getCharacter(from url: String) -> Observable<MovieCharacter>
}

