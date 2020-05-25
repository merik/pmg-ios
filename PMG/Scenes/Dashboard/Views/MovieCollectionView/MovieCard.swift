//
//  MovieCard.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit
import SnapKit

class MovieCard: UIView {
    
    // MARK: Properties
    var contentView = UIView()
    var movieTitleLabel: UILabel!
    var moviePosterImageView: UIImageView!
    var directorLabel: UILabel!
    
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
        
        // Configure layer
        layer.masksToBounds = false
        layer.cornerRadius  = 6.0
        
        layer.shadowOffset  = CGSize(width: 0.0, height: 4.0)
        layer.shadowRadius  = 6.0
        layer.shadowColor   = UIColor(pmgDark: .shadowLight).cgColor
        layer.shadowOpacity = 1.0
        layer.borderWidth   = 1.0
        layer.borderColor   = UIColor(pmg: .quietLighter).cgColor
        
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
            make.edges.equalToSuperview()
        }
        imageView.image = UIImage(named: "space")
        
        // Movie title
        let titleLabel = UILabel()
        self.movieTitleLabel = titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.text = ""
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(pmg: .white)
        titleLabel.numberOfLines = 0
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(5)
        }
       
        // Director
   
        let directorLabel = UILabel()
        self.directorLabel = directorLabel
        directorLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        directorLabel.text = ""
        directorLabel.textAlignment = .center
        directorLabel.textColor = UIColor(pmg: .white)
        
        contentView.addSubview(directorLabel)
        
        directorLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.roundCorners(corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], radius: 6)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 6).cgPath
    }
    
    func setInfo(movie: Movie) {
        self.movieTitleLabel.text = movie.title
        self.movieTitleLabel.sizeToFit()
        self.directorLabel.text = movie.director
       
    }
    
}

