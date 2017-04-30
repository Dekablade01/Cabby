//
//  HistoryDetailViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/30/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    
    var history = History()

    @IBOutlet weak var dateAndTimeLabel: UILabel!
    var dateAndTime:String {
        get {return dateAndTimeLabel.text ?? "" }
        set {dateAndTimeLabel.text = newValue }
    }
    @IBOutlet weak var bookingContainer: UIView!
    @IBOutlet weak var bookingidLabel: UILabel!
    var bookingID:String {
        get {return bookingidLabel.text ?? "" }
        set {bookingidLabel.text = newValue }
    }
    @IBAction func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingContainer.backgroundColor = .clear
        
        dateAndTime = history.time
        destinationname = history.destination
        originName = history.origin
        
 

    }

    @IBOutlet weak var originLabel: UILabel!
    var originName: String {
        get {return originLabel.text ?? ""}
        set {originLabel.text = newValue }
    }
    @IBOutlet weak var destinationLabel: UILabel!
    var destinationname: String {
        get { return destinationLabel.text ?? "" }
        set {destinationLabel.text = newValue }
    }




}
