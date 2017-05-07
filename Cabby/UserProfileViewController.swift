//
//  UserProfileViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 5/7/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var surnameTextField: WhiteFormTextField!
    @IBOutlet weak var passwordTextField: WhiteFormTextField!
    @IBOutlet weak var emailTextField: WhiteFormTextField!
    @IBOutlet weak var phoneTextField: WhiteFormTextField!
    @IBOutlet weak var nameTextField: WhiteFormTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    @IBAction func pressedClose(_ sender: UIButton) {
        dismiss()
    }
    func dismiss()
    {
        self.dismiss(animated: true, completion: nil)
    }


    @IBAction func pressedSave(_ sender: UIButton) {
        dismiss()
    }

}
