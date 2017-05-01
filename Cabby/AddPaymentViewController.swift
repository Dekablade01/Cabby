//
//  AddPaymentViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/21/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import RealmSwift
import UIKit
import FormTextField
import Formatter
import InputValidator
import Validation


class AddPaymentViewController: UIViewController
{
    @IBOutlet weak var cardNumberTextField: WhiteFormTextField!
    @IBOutlet weak var cvvTextField: WhiteFormTextField!
    @IBOutlet weak var expireDateTextField: WhiteFormTextField!
    
    let fields = Field.fields()

    @IBOutlet weak var countryTextField: WhiteFormTextField!
    
    var cardNumber: String {
        get { return cardNumberTextField.text ?? "" }
        set { cardNumberTextField.text = newValue }
    }
    var expireDate: String {
        get { return expireDateTextField.text ?? ""}
        set { expireDateTextField.text = newValue }
    }

    var cvv: String {
        get { return cvvTextField.text ?? "" }
        set { cvvTextField.text = newValue }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTextField.isEnabled = false
        let cField = self.fields[4]
        let eField = self.fields[5]
        let vField = self.fields[6]
        setupFormTextField(formTextField: cardNumberTextField, with: cField)
        
        setupFormTextField(formTextField: expireDateTextField, with: eField)
        setupFormTextField(formTextField: cvvTextField, with: vField)
//        setTextFieldColor()
        
        
        

    }
    
    func setTextFieldColor()
    {
        self.setupTextField(textField: cardNumberTextField, placeHolderString: "", placeHolderColor: .white, borderColor: .white, borderWidth: 1)
        self.setupTextField(textField: expireDateTextField, placeHolderString: "", placeHolderColor: .white, borderColor: .white, borderWidth: 1)
        self.setupTextField(textField: cvvTextField, placeHolderString: "", placeHolderColor: .white, borderColor: .white, borderWidth: 1)
    }
    func setupFormTextField(formTextField: FormTextField, with field: Field)
    {
        formTextField.inputValidator = field.inputValidator
        formTextField.inputType = field.inputType
        formTextField.formatter = field.formatter

    }


     func submit()
    {
        if( cardNumber.characters.count == 19 &&
            expireDate.characters.count == 5  &&
            cvv.characters.count == 3)
        {
            let card = createCardFrom(cardNumber: cardNumber,
                                      expireDate: expireDate,
                                      cvv: cvv)
            
            addCardToRealm(card: card)
            
        }
        else
        {

            showAlertMessage(title: "Something went wrong",
                             message: "Please Enter Correct Information",
                             button: "OK")
        }
    }

    func getLast(n: Int, of string:String) -> String
    {
        let last = string.substring(from:string.index(string.endIndex,
                                                       offsetBy: n * -1))
        
        return last
    }
    
    

    
    func createCardFrom(cardNumber: String, expireDate: String, cvv: String) -> Card
    {
        let card = Card()
        card.cardNumber = cardNumber
        card.expireDate = expireDate
        card.cvv = cvv
        card.displayCardNumber = getLast(n: 4, of: cardNumber)
        
        return card
        
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
    
    func customStringFormatting(of str: String) -> String {
        return str.characters.chunk(n: 4)
            .map{ String($0) }.joined(separator: " ")
    }
    @IBAction func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonHandler(_ sender: Any) {
        submit()

    }
}



extension Collection {
    public func chunk(n: IndexDistance) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}
