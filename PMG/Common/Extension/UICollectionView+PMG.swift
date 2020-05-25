//
//  UICollectionView+PMG.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

extension UICollectionView {
    func beginRefreshing(withAction: Bool) {
        guard let refreshControl = refreshControl, !refreshControl.isRefreshing else {
            return
        }
        refreshControl.beginRefreshing()
        if withAction {
            refreshControl.sendActions(for: .valueChanged)
        }
        let contentOffset = CGPoint(x: 0, y: -refreshControl.frame.height)
        setContentOffset(contentOffset, animated: true)
    }
    
    func endRefreshing() {
        refreshControl?.endRefreshing()
    }
    
}
