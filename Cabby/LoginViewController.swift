//
//  ViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var LoginButton: UIButton!

    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    let placeHolder = NSMutableAttributedString()
    let whiteColor: UIColor = .white
    
    func setupTextField (textField: UITextField, placeHolderString: String)
    {
       
        textField.attributedPlaceholder = NSAttributedString(string:placeHolderString   ,
                                                             attributes:[NSForegroundColorAttributeName: UIColor.white])
        textField.layer.borderColor = whiteColor.cgColor
        textField.layer.borderWidth = 1.0
    }

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTextField(textField: usernameTextField,
                       placeHolderString: "Username")
        setupTextField(textField: passwordTextField,
                       placeHolderString: "Password")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

