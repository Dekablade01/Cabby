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
    let whiteColor: UIColor = .white

    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
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
    
    func setupButtonView()
    {
        facebookButton.imageView?.contentMode = .scaleAspectFit
        googleButton.imageView?.contentMode = .scaleAspectFit
        let edge:CGFloat = 15
        facebookButton.imageEdgeInsets = UIEdgeInsetsMake(edge, edge, edge, edge)
        googleButton.imageEdgeInsets = UIEdgeInsetsMake(edge, edge, edge, edge)
        loginButton.titleEdgeInsets.bottom = 0
        loginButton.titleEdgeInsets.top = 0
        loginButton.titleEdgeInsets.left = 0
        loginButton.titleEdgeInsets.right = 0
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        setupButtonView()
        setupTextField(textField: usernameTextField,
                       placeHolderString: "Username",
                       placeHolderColor: .white, borderColor: .white, borderWidth: 1.0)
        setupTextField(textField: passwordTextField,
                       placeHolderString: "Password",
                       placeHolderColor: .white, borderColor: .white, borderWidth: 1.0)
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(UIViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tapGesture)
    
    }
    override var prefersStatusBarHidden : Bool {
        return true
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

