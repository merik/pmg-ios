//
//  PMGNavigationController.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//


import UIKit

class PMGNavigationController: UINavigationController {
    
    var landscapeLocked = false
    var portraitLocked = false
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.barTintColor = UIColor(pmg: .primary)
        self.navigationBar.tintColor = UIColor(pmg: .white)
        self.navigationBar.isTranslucent = false
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.navigationBar.barTintColor = UIColor(pmg: .primary)
        self.navigationBar.tintColor = UIColor(pmg: .white)
        self.navigationBar.isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController Orientations
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if self.portraitLocked {
            return .portrait
        }
        
        if !self.landscapeLocked {
            return super.supportedInterfaceOrientations
        }
        return UIInterfaceOrientationMask.landscape
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if self.portraitLocked {
            return .portrait
        }
        if !self.landscapeLocked {
            return super.preferredInterfaceOrientationForPresentation
        }
        
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            return UIInterfaceOrientation.landscapeRight
        } else if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            return UIInterfaceOrientation.landscapeLeft
        }
        
        return UIInterfaceOrientation.landscapeRight
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
