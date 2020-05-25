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
    
    func refresh() {
        output.isLoading.accept(true)
        refreshMovies()
    }
    
    private func refreshMovies() {
        MovieDataManager.shared.getMovies().asObservable()
            .observeOn(MovieDataManager.networkQueue)
            .subscribe(onNext: {[weak self] movies in
                self?.output.isLoading.accept(false)
                self?.output.movies.accept(movies)
            }, onError: {[weak self] error in
                    self?.output.isLoading.accept(false)
                    // ignore error handling for now
            }).disposed(by: disposeBag)
    }
    
}
