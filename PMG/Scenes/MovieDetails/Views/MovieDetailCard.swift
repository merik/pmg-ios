//
//  MovieDetailCard.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit
import SnapKit

class MovieDetailCard: UIView {
    
    // MARK: Properties
    var contentView = UIView()
    var movieTitleLabel: UILabel!
    var moviePosterImageView: UIImageView!
    var directorLabel: UILabel!
    var producerLabel: UILabel!
    var releaseDateLabel: UILabel!
    var episodeIdLabel: UILabel!
    var openingCrawlLabel: UILabel!
    
    // MARK: Methods
    required init() {
        super.init(frame: .zero)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = false
        backgroundColor = UIColor.white
        
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        let imageView = UIImageView()
        self.moviePosterImageView = imageView
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(100)
        }
        
        // Movie title
        let titleLabel = UILabel()
        self.movieTitleLabel = titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.text = ""
        titleLabel.textAlignment = .center
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(22)
            make.top.equalTo(imageView.snp.bottom).offset(-27)
        }
       
        // Opening Crawl
        
        let openingCrawlLabel = UILabel()
        self.openingCrawlLabel = openingCrawlLabel
        openingCrawlLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        openingCrawlLabel.text = ""
        openingCrawlLabel.textAlignment = .left
        openingCrawlLabel.numberOfLines = 3
             
        contentView.addSubview(openingCrawlLabel)
             
        openingCrawlLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(66)
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
             
        // Director
   
        let directorLabel = UILabel()
        self.directorLabel = directorLabel
        directorLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        directorLabel.text = ""
        directorLabel.textAlignment = .left
        
        contentView.addSubview(directorLabel)
        
        directorLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(22)
            make.top.equalTo(openingCrawlLabel.snp.bottom).offset(5)
        }
        
        // Producer
        
        let producerLabel = UILabel()
        self.producerLabel = producerLabel
        producerLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        producerLabel.text = ""
        producerLabel.textAlignment = .left
        
        contentView.addSubview(producerLabel)
        
        producerLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(22)
            make.top.equalTo(directorLabel.snp.bottom).offset(5)
        }
        
        layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setMovie(_ movie: Movie) {
        self.movieTitleLabel.text = movie.title
        self.directorLabel.text = "Director: \(movie.director)"
        self.openingCrawlLabel.text = movie.openingCrawl
        self.producerLabel.text = "Producer: \(movie.producer)"
    }
    
}

