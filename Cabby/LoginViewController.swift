//
//  ViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    let placeHolder = NSMutableAttributedString()
    let whiteColor: UIColor = .white
    
    func setupNavigationController ()
    {
        self.navigationController?
            .navigationBar
            .setBackgroundImage(UIImage(),
                                for: .default)
        self.navigationController?
            .navigationBar
            .shadowImage = UIImage()
        self.navigationController?
            .navigationBar
            .isTranslucent = true
        self.navigationController?
            .view
            .backgroundColor = .clear
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupTextField(textField: usernameTextField,
                       placeHolderString: "Username", placeHolderColor: .white)
        setupTextField(textField: passwordTextField,
                       placeHolderString: "Password", placeHolderColor: .white)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tapGesture)
    
    }




    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    @IBAction func pressLoginButtonHandler(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootViewController")
        
        self.present(rootViewController, animated: true, completion: nil)
        
    }
    @IBAction func pressSignUpHandler(_ sender: Any) {
    }
    @IBAction func pressForgetPasswordHandler(_ sender: Any) {
    }
    @IBAction func pressFacebookHandler(_ sender: Any) {
    }
    @IBAction func pressGoogleHandler(_ sender: Any) {
    }

}

