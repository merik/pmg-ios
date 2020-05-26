//
//  DashboardViewController.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DashboardViewController: UIViewController {
    
    let viewModel: DashboardViewModel!
    let disposeBag = DisposeBag()
    
    let collectionView: MovieCollectionView = {
        let collectionView = MovieCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        return collectionView
    }()
    
    // MARK: - Static methods
    class func navigationController(viewModel: DashboardViewModel) -> UINavigationController {
        let viewController = DashboardViewController(viewModel: viewModel)
        let navigationController  = PMGNavigationController(rootViewController: viewController)
        
        return navigationController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Movies".uppercased()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.collectionViewLayout.invalidateLayout()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        setLeftButtons([], animated: false)
        
        collectionView.movieCollectionViewDelegate = self
        setupRx()
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refresher
        viewModel.getMovies()
    }
    
    @objc func refresh() {
        viewModel.refresh()
    }
    
    private func setupRx() {
        viewModel.output.isLoading.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[unowned self] loading in
                if loading {
                    self.collectionView.beginRefreshing(withAction: false)
                } else {
                    self.collectionView.endRefreshing()
                }
            }).disposed(by: disposeBag)
        
        viewModel.output.movies.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] movies in
                self.showMovies(movies)
            }).disposed(by: disposeBag)
        
       
    }
    
    private func showMovies(_ movies: [Movie]) {
        collectionView.movies  = movies
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

extension DashboardViewController: MovieCollectionViewDelegate {
    func didTapOnMovie(_ collectionView: MovieCollectionView, movie: Movie) {
        let movieDetailViewModel = MovieDetailViewModel(movie: movie)
        let movieDetailViewController = MovieDetailViewController.controller(viewModel: movieDetailViewModel)
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
}
