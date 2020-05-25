//
//  CharacterCollectionViewCell.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    var card: CharacterCard!
    
    func setCharacter(_ character: MovieCharacter) {
        self.character = character
    }
    
    private var character: MovieCharacter? = nil {
        didSet {
            guard let character = character else {
                return
            }
            card.setCharacter(character)
        }
    }
    
    class var reuseIdentifierString: String {
        return "CharacterCollectionViewCell"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(pmg: .white)
        isAccessibilityElement = true
        card = CharacterCard()
        
        contentView.addSubview(card)
        card.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

