//
//  MovieDetailViewController.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//


import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MovieDetailViewController: UIViewController {
    
    let viewModel: MovieDetailViewModel!
    let disposeBag = DisposeBag()
    
    let movieDetailCard: MovieDetailCard = {
        let card = MovieDetailCard(frame: .zero)
        return card
    }()
    
    let collectionView: CharacterCollectionView = {
        let collectionView = CharacterCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        return collectionView
    }()
    
    // MARK: - Static methods
    class func controller(viewModel: MovieDetailViewModel) -> MovieDetailViewController {
        let viewController = MovieDetailViewController(viewModel: viewModel)
        return viewController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = viewModel.movieTitle.uppercased()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.collectionViewLayout.invalidateLayout()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(movieDetailCard)
        view.addSubview(collectionView)
        
        movieDetailCard.snp.makeConstraints {(make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(270)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(movieDetailCard.snp.bottom).offset(1)
        }
        
        setLeftButtons(["header-icon-back"], animated: false)
        
        setupRx()
        viewModel.showMovie()
    }
   
    private func setupRx() {
        viewModel.output.isLoading.asObservable().skip(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[unowned self] loading in
                if loading {
                    self.collectionView.beginRefreshing(withAction: false)
                } else {
                    self.collectionView.endRefreshing()
                }
            }).disposed(by: disposeBag)
        
        viewModel.output.movie.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[unowned self] movie in
                self.showMovie(movie)
            }).disposed(by: disposeBag)
        
        viewModel.output.character.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[unowned self] character in
                self.updateCharacter(character)
            }).disposed(by: disposeBag)
       
    }
    
    private func showMovie(_ movie: Movie?) {
        guard let movie = movie else {
            return
        }
        movieDetailCard.setMovie(movie)
        collectionView.characters = movie.characters
    }
    
    private func updateCharacter(_ character: MovieCharacter?) {
        
        guard let character = character else {
            return
        }
        
        collectionView.updateCharacter(character)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
        }, completion: { _ in
            self.collectionView.sizeChanged(to: size)       // size after orientation has changed
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.sizeChanged(to: self.view.bounds.size)
        self.collectionView.updateVisibleCollectionViewCells()
    }
   
}
