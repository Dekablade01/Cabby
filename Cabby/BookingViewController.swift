//
//  MainViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Then
import GoogleMaps
import SnapKit


class BookingViewController: UIViewController {
    
    
    @IBOutlet weak var originTextField: TextField!
    @IBOutlet weak var destinationTextField: TextField!

    @IBOutlet weak var viewForMapView: UIView!
    
    var origin:String { return originTextField.text ?? ""}
    var destination:String { return destinationTextField.text ?? ""}

    @IBOutlet weak var accountBarButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        setupNavigationBar()
        setupMapView()
        setupTextFieldForThisViewController()
        
    }
    @IBAction func leftSideMenuPressed() {
        self.sideViewController()!.toogleLeftViewController()
        
//        if self.sideViewController()!.leftViewControllerVisible {
//            self.sideViewController()!.hideLeftViewController()
//        } else {
//            self.sideViewController()!.presentLeftViewController(0.5, dampingRatio: 0.4, velocity: 10, options: .curveEaseIn)
//        }
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
    override var prefersStatusBarHidden : Bool {
        return true
    }
    func setupMapView()
    {
        let camera = GMSCameraPosition.camera(withLatitude: 13.725934,
                                              longitude: 100.770596,
                                              zoom: 15)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true

        
        viewForMapView.addSubview(mapView)
        
        mapView.snp.makeConstraints(){
            $0.size.equalTo(mapView.superview!)
            $0.center.equalTo(mapView.superview!)
        }
    }
    func googleMapAutoComplete(){
        
    }
    func textFieldDidChange()
    {
        print("hello")
    }
    func setupTextFieldForThisViewController()
    {
        textFieldForThisViewController(textField: originTextField)
        textFieldForThisViewController(textField: destinationTextField)
        
        self.setupTextField(textField: originTextField, placeHolderString: "จุดนัดพบ",placeHolderColor: .black)
        self.setupTextField(textField: destinationTextField, placeHolderString: "จุดหมายปลายทาง", placeHolderColor: .black)
    }
    func textFieldForThisViewController(textField: UITextField)
    {
        textField.layer.borderColor = UIColor.black.cgColor
        textField.addTarget(self,
                            action: #selector(BookingViewController.textFieldDidChange),
                            for: .editingChanged)
        
    }
}

