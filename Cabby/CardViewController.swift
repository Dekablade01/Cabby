//
//  CardViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/23/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import FormTextField

class CardViewController: UIViewController {

    @IBOutlet weak var cardNumberTextField: WhiteFormTextField!
    @IBOutlet weak var expiredateTextField: WhiteFormTextField!
    
    var displayCardNumber = ""
    
    let fields = Field.fields()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cField = fields[4]
        let eField = fields[5]
        
        setupFormTextField(formTextField: cardNumberTextField, with: cField)
        setupFormTextField(formTextField: expiredateTextField, with: eField)
        
        cardNumberTextField.text = "•••• •••• ••••" + " " + displayCardNumber
        expiredateTextField.text = "••/••"
        


    }
    func setupFormTextField(formTextField: FormTextField, with field: Field)
    {
        formTextField.inputValidator = field.inputValidator
        formTextField.inputType = field.inputType
        formTextField.formatter = field.formatter
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    



}
