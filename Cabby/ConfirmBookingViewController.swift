//
//  ConfirmBookingViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 5/1/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class ConfirmBookingViewController: UIViewController {

    @IBOutlet weak var emergencyView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emergencyView.backgroundColor = .clear
        
        
  
    }

    @IBAction func dismiss(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
