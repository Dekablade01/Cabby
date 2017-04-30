//
//  BookingPaymentViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 5/1/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class BookingPaymentViewController: UIViewController {
    
    var cards:[Card] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let card1 = Card()
        card1.cardNumber = "XXXX 3876"
        card1.status = true
        
        let card2 = Card()
        card2.cardNumber = "XXXX 6745"
        card2.status = false
        
        cards.append(card1)
        cards.append(card2)
        
    }
    
    @IBAction func popViewController(_ sender: Any)
    {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension BookingPaymentViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
       if section == 0
       {
         return cards.count
        }
        else
       {
        return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
            
            let card = cards[indexPath.item]
            cell.cardNumber = card.cardNumber
            cell.status = card.status
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath)
            return cell 
        }
    }
}
