//
//  PaymentViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/18/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RealmSwift

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var paymentCollectionView: UICollectionView!
    
    var cards = [Card]()
    
    var numberOfCards: Int { return cards.count }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadCards()
        
        setupCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadCards()
    }

    func loadCards()
    {
        cards.removeAll()
        let realm = try! Realm()
        
        let result = realm.objects(Card.self)
        
        for card in result
        {
            cards.append(card)
        }
        paymentCollectionView.reloadData()
    }
    @IBAction func dissmissViewControllerHandler(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    override var prefersStatusBarHidden : Bool
    {
        return true
    }

    @IBAction func saveButtonHandler(_ sender: Any) {
        
    }
    
    func setupCollectionView()
    {
        paymentCollectionView.dataSource = self
        paymentCollectionView.delegate = self
    }
}

extension PaymentViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0)
        {
            return numberOfCards
        }
        else
        {
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var realCell = UICollectionViewCell()
        if (indexPath.section == 1)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath)
            
            realCell = cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        
            cell.status = cards[indexPath.item].status
            cell.cardNumber = cards[indexPath.item].displayCardNumber
            
            realCell = cell
        }
        return realCell
    }
}
extension PaymentViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }

}
