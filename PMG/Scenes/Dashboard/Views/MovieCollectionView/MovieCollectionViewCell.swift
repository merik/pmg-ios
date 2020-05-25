//
//  MovieCollectionViewCell.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var card: MovieCard!
    
    func setInfo(movie: Movie) {
        self.movie = movie
    }
    
    private var movie: Movie? = nil {
        didSet {
            guard let movie = movie else {
                return
            }
            card.setInfo(movie: movie)
        }
    }
    
    class var reuseIdentifierString: String {
        return "MovieCollectionViewCell"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(pmg: .white)
        isAccessibilityElement = true
        card = MovieCard()
        
        contentView.addSubview(card)
        card.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

