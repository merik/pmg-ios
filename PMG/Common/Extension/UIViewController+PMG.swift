//
//  UIViewController+PMG.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

extension UIViewController {
    
    internal func generateBarButtonItem(_ imageName: String, selector: Selector) -> UIBarButtonItem {
        let barButtonItem: UIBarButtonItem
        if imageName == "system-item-action" {
            barButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: selector)
        } else if imageName == "system-item-add" {
            barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: selector)
        } else if let image =  UIImage(named: imageName) {
            barButtonItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: selector)
        } else {
            barButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: selector)
        }
        return barButtonItem
    }
    
    @objc func setLeftButtons(_ imageNames: [String], animated: Bool) {
        if imageNames.isEmpty {
            self.navigationItem.setLeftBarButtonItems(nil, animated: animated)
        } else {
            var leftBarButtonItems = [UIBarButtonItem]()
            for (index, imageName) in imageNames.enumerated() {
                let barButtonItem = self.generateBarButtonItem(imageName, selector: #selector(UIViewController.didTapLeftButton(_:)))
                barButtonItem.tag = index
                barButtonItem.tintColor = UIColor(pmg: .white)
                leftBarButtonItems.insert(barButtonItem, at: 0)
            }
            self.navigationItem.setLeftBarButtonItems(leftBarButtonItems, animated: animated)
        }
    }
    
    @objc func didTapLeftButton(_ sender: AnyObject?) {
        guard let navigationController = self.navigationController else {return}
        if let firstViewController = navigationController.viewControllers.first, self == firstViewController {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController!.popViewController(animated: true)
        }
    }
    
}
