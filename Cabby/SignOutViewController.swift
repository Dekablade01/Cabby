//
//  SignOutViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/23/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class SignOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    @IBAction func signoutHandler(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        
        self.present(viewController, animated: true, completion: nil)
    }

    @IBAction func dismissViewController(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
