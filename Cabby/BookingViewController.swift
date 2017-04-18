//
//  MainViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Then

class BookingViewController: UIViewController {
    
    
    @IBOutlet weak var originTextField: TextField!
    @IBOutlet weak var destinationTextField: TextField!
    
    var origin:String { return originTextField.text ?? ""}
    var destination:String { return destinationTextField.text ?? ""}

    @IBOutlet weak var accountBarButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        setupNavigationBar()
        originTextField.layer.borderColor = UIColor.black.cgColor
        destinationTextField.layer.borderColor = UIColor.black.cgColor
        
        self.setupTextField(textField: originTextField, placeHolderString: "จุดนัดพบ",placeHolderColor: .black)
        self.setupTextField(textField: destinationTextField, placeHolderString: "จุดหมายปลายทาง", placeHolderColor: .black)
    }
    @IBAction func leftSideMenuPressed() {
//        self.sideViewController()!.toogleLeftViewController()
        
        if self.sideViewController()!.leftViewControllerVisible {
            self.sideViewController()!.hideLeftViewController()
        } else {
            self.sideViewController()!.presentLeftViewController(0.5, dampingRatio: 0.4, velocity: 10, options: .curveEaseIn)
        }
    }
    
    @IBAction func rightSideMenuPressed() {
        if self.sideViewController()!.rightViewControllerVisible {
            self.sideViewController()!.hideRightViewController()
        } else {
            self.sideViewController()!.presentRightViewController(0.5, dampingRatio: 0.4, velocity: 10, options: .curveEaseIn)
        }
    }
    
    func setupNavigationBar ()
    {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
}
