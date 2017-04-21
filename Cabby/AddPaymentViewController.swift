//
//  AddPaymentViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/21/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RealmSwift

class AddPaymentViewController: UIViewController
{
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var ownerNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func insertPaymentHandler(_ sender: UIButton)
    {
        if( (cardNumberTextField.text?.characters.count)! == 16 &&
            Int(monthTextField.text!)! >= 12  &&
            (yearTextField.text?.characters.count)! == 4  &&
            isFilled(textField: ownerNameTextField)  )
        {
            createCard(cardNumber: cardNumberTextField.text!,
                       month: monthTextField.text!,
                       year: yearTextField.text!,
                       ownerName: ownerNameTextField.text!)
        }
        else
        {
            showAlertMessage(title: "Something went wrong",
                             message: "Please Enter Correct Information",
                             button: "OK")
        }
    }
    func isFilled(textField: UITextField) -> Bool
    {
        if (textField.text != "")
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    

    
    func createCard(cardNumber: String, month: String, year: String, ownerName: String)
    {
        let card = Card()
        card.cardNumber = cardNumber
        
        let last4 = cardNumber.substring(from:cardNumber.index(cardNumber.endIndex, offsetBy: -4))
        card.displayCardNumber = "XXXX-" + last4

        card.month = month
        card.year = year
        card.ownerName = ownerName
        
        addCardToRealm(card: card)
    }
    
    func addCardToRealm(card: Card)
    {
        let realm = try! Realm()
        try! realm.write {
            realm.add(card)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showAlertMessage(title: String, message: String, button: String)
    {
        let actionSheetController = UIAlertController(title: title,
                                                      message: message,
                                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: button, style: .cancel)
        
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
}
