//
//  RootViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/18/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import LFSideViewController


class RootViewController: LFSideViewController, LFSideViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "My", bundle: nil)
        self.contentViewController = storyboard.instantiateViewController(withIdentifier: "NavigationViewController")
        self.leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController")
        
        if let sideViewController = self.sideViewController() {
            sideViewController.delegate = self
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override var prefersStatusBarHidden : Bool {
        return true
    }

    
    
    
}
