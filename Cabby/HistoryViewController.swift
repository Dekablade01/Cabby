//
//  HistoryViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/29/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var histories: [History] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let history1 = History(origin: "Route66 , RCA",
                               destination: "66 Ingnam house",
                               time: "13 Apr 2017 , 02 : 30 AM.",
                               favoured: true)
        let history2 = History(origin: "MOONSOON Mega Bangna",
                               destination: "66 Ingnam house",
                               time: "10 Mar 2017 , 02 : 15 AM.",
                               favoured: false)
        
        histories.append(history1)
        histories.append(history2)

    }

  
    @IBAction func dismiss(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    


}


extension HistoryViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return histories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HistoryCollectionViewCell
        
        let history = histories[indexPath.item]
        cell.time = history.time
        cell.origin = history.origin
        cell.destination = history.destination
        
        if( history.favoured == false )
        {
            cell.favouriteIcon.setBackgroundImage(#imageLiteral(resourceName: "blank-favourite"), for: .normal)

        }
        else
        {
            cell.favouriteIcon.setBackgroundImage(#imageLiteral(resourceName: "favourite-icon"), for: .normal)
        }
        return cell
    }
}

extension HistoryViewController: UICollectionViewDelegateFlowLayout
{
    
}
