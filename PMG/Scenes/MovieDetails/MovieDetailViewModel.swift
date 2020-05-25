//
//  MovieDetailViewModel.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel {
    let semaphore = DispatchSemaphore(value: 1)
    
    var movie: Movie
    
    private let disposeBag = DisposeBag()
    let output: Output
    
    struct Output {
        let isLoading = PublishRelay<Bool>()
        let character = BehaviorRelay<MovieCharacter?>(value: nil)
        let movie = BehaviorRelay<Movie?>(value: nil)
    }
    
    init (movie: Movie) {
        self.movie = movie
        output = Output()
    }
    
    var movieTitle: String {
        return movie.title
    }
    
    func showMovie() {
        output.movie.accept(movie)
        getCharacters()
    }
    
    private func getCharacters() {
        for character in movie.characters {
            getCharacter(character)
        }
    }
    
    private func getCharacter(_ character: MovieCharacter) {
        MovieDataManager.shared.getMovieCharacter(from: character.url)
        .asObservable()
            .observeOn(MovieDataManager.networkQueue)
            .subscribe(onNext: {[weak self] character in
                self?.semaphore.wait()
                self?.output.character.accept(character)
                self?.semaphore.signal()
            }).disposed(by: disposeBag)
    }
}
