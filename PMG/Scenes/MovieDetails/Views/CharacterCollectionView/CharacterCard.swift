//
//  CharacterCard.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit
import SnapKit

class CharacterCard: UIView {
    
    // MARK: Properties
    var contentView = UIView()
    var imageView: UIImageView!
    var nameLabel: UILabel!
    
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
        self.imageView = imageView
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        
        // Character Name
        let nameLabel = UILabel()
        self.nameLabel = nameLabel
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nameLabel.text = ""
        nameLabel.textAlignment = .center
               
        contentView.addSubview(nameLabel)
               
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
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
    
    func setCharacter(_ character: MovieCharacter) {
        self.nameLabel.text = character.name
    }
    
}

