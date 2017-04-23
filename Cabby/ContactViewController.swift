//
//  ContactViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/23/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var textField: WhiteFormTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.padding = UIEdgeInsets(top: 20, left: 15, bottom: 0, right: 15)
        setupTextField(textField: textField, placeHolderString: "กรุณากรอกแสดงความคิดเห็น", placeHolderColor: .white, borderColor: .white, borderWidth: 1)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }



}
