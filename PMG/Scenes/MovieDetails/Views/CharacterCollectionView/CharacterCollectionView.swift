//
//  CharacterCollectionView.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

struct CharacterCollectionViewStyle {
    static let margin = CGFloat(16.0)
    static let marginTop = CGFloat(16.0)
    static let marginBottom = CGFloat(16.0)
    static let marginLeft = CGFloat(16.0)
    static let marginRight = CGFloat(16.0)
    static let minWidth = CGFloat(100)
    static let optimalWidth = CGFloat(150)
    static let cellHeight = CGFloat(136)
    static let titleColor = UIColor.gray
    static let sectionBackgroundColor  = UIColor(pmg: .black)
    static let separatorHeight = CGFloat(1)
    static let cornerRadius  = 8.0
    static let shadowOffset  = CGSize(width: 0.0, height: 4.0)
    static let shadowRadius  = 6.0
    static let borderWidth   = 1.0
    static let shadowOpacity = 1.0
   
}

class CharacterCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let cellName = CharacterCollectionViewCell.reuseIdentifierString
    
    private var containerSize: CGSize = .zero {
        didSet {
            self.collectionViewLayout.invalidateLayout()
        }
    }
    
    func updateVisibleCollectionViewCells() {
        for tuple in self.visibleCells.enumerated() {
            let currentCell = tuple.element
            if let cell = currentCell as? CharacterCollectionViewCell {
                cell.layoutIfNeeded()
            }
        }
    }
    
    private var safeArea: UIEdgeInsets {
        if #available(iOS 11, *) {
            return self.safeAreaInsets
        }
        return .zero
    }
   
    var characters = [MovieCharacter]() {
        didSet {
            self.collectionViewLayout.invalidateLayout()
            reloadData()
        }
    }
    
    func updateCharacter(_ character: MovieCharacter) {
        guard let index = characters.firstIndex(where: {$0.url == character.url}) else {
            return
        }
        
        characters[index].name = character.name
        reloadItems(at: [IndexPath(item: index, section: 0)])
        
    }
    
    func sizeChanged(to size: CGSize) {
        containerSize = size
    }
    
    private func configLayout(with containerSize: CGSize) {
        let layout = PMGCollectionViewLayout()
        layout.scrollDirection = .vertical
        self.collectionViewLayout = layout
        
        self.isPagingEnabled = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.allowsMultipleSelection = false
        self.backgroundColor = UIColor(pmg: .white)
        self.alwaysBounceVertical = true
        self.bounces = true
        
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
            layout.sectionInsetReference = .fromSafeArea
        }
        
    }
    
    private func initCollectionView(with containerSize: CGSize) {
        self.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: cellName)
        self.dataSource = self
        self.delegate = self
        
        configLayout(with: containerSize)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initCollectionView(with: frame.size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: CharacterCollectionViewStyle.marginTop, left: CharacterCollectionViewStyle.marginLeft, bottom: CharacterCollectionViewStyle.marginBottom, right: CharacterCollectionViewStyle.marginRight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CharacterCollectionViewStyle.margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CharacterCollectionViewStyle.marginBottom
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? CharacterCollectionViewCell {
            let character = characters[indexPath.item]
            cell.setCharacter(character)
            return cell
        }
        // should never reach here
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = containerSize.width < 1 ? collectionView.bounds.size.width : containerSize.width
        
        let cellWidth = PMGCollectionViewLayout.calculateOptimalSizeWidth(
                    minWidth: CharacterCollectionViewStyle.optimalWidth,
                    collectionWidth: width,
                    marginLeft: CharacterCollectionViewStyle.marginLeft + safeArea.left,
                    marginRight: CharacterCollectionViewStyle.marginRight + safeArea.right,
                    margin: CharacterCollectionViewStyle.margin)
        
        let height = cellWidth + 40
        return CGSize(width: cellWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
}
