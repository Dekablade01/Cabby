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

    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emergencyView.backgroundColor = .clear
        
        originLabel.text = SingletonTrip.trip.origin?.name
        
        destinationLabel.text = SingletonTrip.trip.destination?.name
        
        dateLabel.text = SingletonTrip.trip.date
        timeLabel.text = SingletonTrip.trip.time
  
    }

    @IBAction func dismiss(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
}
