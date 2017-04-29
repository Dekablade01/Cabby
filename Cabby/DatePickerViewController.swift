//
//  DatePickerViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/29/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    
    @IBOutlet weak var dateContainerView: UIView!
    @IBOutlet weak var timeContainerView: UIView!
    @IBOutlet weak var datePickerContainerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var handler: ((String, String)->())?
    var dismissHandler: (()->())?
    
    var date: String {
        set { dateLabel.text = newValue }
        get { return dateLabel.text ?? ""}
    }
    var containerHeight: CGFloat = 0.0
    
    @IBOutlet weak var timeLabel: UILabel!
    var time: String {
        set { timeLabel.text = newValue }
        get { return timeLabel.text ?? ""}
    }
    @IBAction func pressDateHandler(_ sender: UIButton) {
        showDatePicker()
    }
    @IBAction func pressTimeHandler(_ sender: Any) {
        showDatePicker()
    }
    @IBAction func datePickerHandler(_ sender: UIDatePicker) {
        let date = sender.date
        setDateToView(date: date)
        setTimeToView(date: date)
    }
    
    func getCurrentDate()
    {
        let date = Date()
        setDateToView(date: date)
        setTimeToView(date: date)
    }
    
    func setDateToView(date: Date)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd | MM | yyyy"
        self.date = dateFormatter.string(from: date)
    }
    func setTimeToView(date : Date)
    {
        let timeFormatter = DateFormatter()
        timeFormatter.amSymbol = "AM"
        timeFormatter.pmSymbol = "PM"
        timeFormatter.dateFormat = "h:mm a"
        self.time = timeFormatter.string(from: date)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePickerContainerView.center.y += self.containerHeight

        getCurrentDate()

        containerHeight = datePickerContainerView.bounds.height
        print(containerHeight)
        print(datePickerContainerView.center.y)
        dateContainerView.backgroundColor = .clear
        timeContainerView.backgroundColor  = .clear

        // Do any additional setup after loading the view.
    }
    @IBAction func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true){
            
            self.handler?(self.date, self.time)
            self.dismissHandler?()
        }
    }
    func showDatePicker()
    {
        print(datePickerContainerView.center.y)
        if (datePickerContainerView.center.y >= 700)
        {
            UIView.animate(withDuration: 0.2){
                self.datePickerContainerView.center.y -= self.containerHeight
                print(self.datePickerContainerView.center.y)
            }
        }
    }

    @IBAction func dismissPicker(_ sender: UIBarButtonItem) {
        
        UIView.animate(withDuration: 0.2){
            self.datePickerContainerView.center.y += self.containerHeight
            print(self.datePickerContainerView.center.y)

        }
    }
    
}

