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
    
    var cardNumber: String {
        get { return cardNumberTextField.text ?? "" }
        set { cardNumberTextField.text = newValue }
    }
    var month: String {
        get { return monthTextField.text ?? ""}
        set { monthTextField.text = newValue }
    }
    var year: String {
        get { return yearTextField.text ?? "" }
        set { yearTextField.text = newValue }
    }
    var owner: String {
        get { return ownerNameTextField.text ?? "" }
        set { ownerNameTextField.text = newValue }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        cardNumberTextField.addTarget(self,
                                      action: #selector(AddPaymentViewController.correctCard),
                                      for: .editingChanged)
        monthTextField.addTarget(self,
                                 action: #selector(AddPaymentViewController.correctMonth),
                                 for: .editingChanged)
        yearTextField.addTarget(self,
                                action: #selector(AddPaymentViewController.correctYear),
                                for: .editingChanged)
        
        
    }

    func correctCard(){
        if (cardNumber.characters.count > 16)
        {
            let first16Chars = String(cardNumber.characters.prefix(16))
            
            cardNumber = first16Chars
        }
    }
    func correctMonth()
    {
        if (month.characters.count > 2)
        {
            let first2Chars = String(month.characters.prefix(2))

            month = first2Chars
        }
    }
    func correctYear()
    {
        if (year.characters.count > 4)
        {
            let first4chars = String(year.characters.prefix(4))
            
            year = first4chars
        }
    }
    @IBAction func insertPaymentHandler(_ sender: UIButton)
    {
        if( cardNumber.characters.count == 16 &&
            Int(month)! <= 12  &&
            year.characters.count == 4  &&
            owner.characters.count > 0  )
        {
            createCard(cardNumber: cardNumberTextField.text!,
                       month: monthTextField.text!,
                       year: yearTextField.text!,
                       ownerName: ownerNameTextField.text!)
        }
        else
        {
            print("cardNumber: \(cardNumber.characters.count)")
            print("month: \(Int(month)!)")
            print("year: \(year.characters.count)")
            print("owner: \(owner.characters.count)")

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

extension AddPaymentViewController: UITextFieldDelegate
{
    
}
