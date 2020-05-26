//
//  DashboardViewModel.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import RxSwift
import RxCocoa

class DashboardViewModel {
    private let disposeBag = DisposeBag()
    let output: Output
    
    struct Output {
        let isLoading = PublishRelay<Bool>()
        let movies = BehaviorRelay<[Movie]>(value: [])
    }
    
    init() {
        output = Output()
    }
    
    func getMovies() {
        output.isLoading.accept(true)
        refreshMovies()
    }
    
    func refresh() {
        output.isLoading.accept(true)
        refreshMovies(onlineOnly: true)
    }
    
    private func refreshMovies(onlineOnly: Bool = false) {
        MovieDataManager.shared.getMovies(from: onlineOnly).asObservable()
            .observeOn(MovieDataManager.networkQueue)
            .subscribe(onNext: {[weak self] movies in
                self?.output.isLoading.accept(false)
                self?.output.movies.accept(movies)
            }, onError: {[weak self] error in
                    self?.output.isLoading.accept(false)
                    // TODO: properly handle error
            }).disposed(by: disposeBag)
    }
    
}
