//
//  NotificationViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 5/1/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    var destination:String {
        get { return destinationLabel.text ?? "" }
        set { destinationLabel.text = newValue }
    }
    @IBOutlet weak var labelContainer: UIView!
    var dismissHandler:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        destination = SingletonTrip.trip.origin?.name ?? ""
        containerView.backgroundColor = .clear
        labelContainer.backgroundColor = .clear
    }
    @IBOutlet weak var destinationLabel: UILabel!

    @IBAction func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        dismissHandler?()
    }

}
