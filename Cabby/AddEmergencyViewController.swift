//
//  AddEmergencyViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/23/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class AddEmergencyViewController: UIViewController {

    @IBOutlet weak var nameTextField: WhiteFormTextField!
    @IBOutlet weak var numberTextField: WhiteFormTextField!
    @IBOutlet weak var statusTextField: WhiteFormTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismiss()
    {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func closeButton(_ sender: Any) {
        dismiss()
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        dismiss()
    }
    
}


