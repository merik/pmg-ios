//
//  PMGCollectionViewLayout.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

class PMGCollectionViewLayout: UICollectionViewFlowLayout {
    // Prevents UICollectionView blanks cells (randomly) when scrolling
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    class func calculateOptimalSizeWidth(minWidth: CGFloat,
                                         collectionWidth: CGFloat,
                                         marginLeft: CGFloat,
                                         marginRight: CGFloat,
                                         margin: CGFloat) -> CGFloat {
        let numCols = max(floor((collectionWidth - marginLeft - marginRight + margin) / (minWidth + margin)), 1)
        let colWidth = max((collectionWidth - marginLeft - marginRight + margin) / numCols - margin, 1)
        return colWidth
    }
    
    class func calculateOptimalColumns(minWidth: CGFloat,
                                       collectionWidth: CGFloat,
                                       marginLeft: CGFloat,
                                       marginRight: CGFloat,
                                       margin: CGFloat) -> Int {
        let numCols = max(Int(floor((collectionWidth - marginLeft - marginRight + margin) / (minWidth + margin)) + 0.001), 1)
        return numCols
    }
    
    static let startPreloadingAtIndex = 15
}
