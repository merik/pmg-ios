//
//  CharacterCollectionViewHeader.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

class CharacterCollectionViewHeader: UICollectionReusableView {
    
    weak var contentView: UIView!
    weak var titleLabel: UILabel!
    
    public class func requiredHeightForHeader() -> CGFloat {
        return 30.0
    }
    
    public class var reuseIdentifierString: String {
        return "CharacterCollectionViewHeader"
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title?.uppercased()
        }
    }
    
    // MARK: - Life cycle
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(pmg: .primary)
        
        let view = UIView()
        contentView = view
        contentView.backgroundColor = .clear
        addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.left.equalTo(safeAreaLayoutGuide.snp.leftMargin)
                make.right.equalTo(safeAreaLayoutGuide.snp.rightMargin)
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            } else {
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .center
        label.textColor = UIColor(pmg: .white)
        self.titleLabel = label
        contentView.addSubview(titleLabel)
      
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        }
        
    }
    
}
