//
//  FavouriteViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/29/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    @IBAction func dismiss(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}


extension FavouriteViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
}
extension FavouriteViewController: UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let heigh = width*788/1827
        
        return CGSize(width: width, height: heigh)
        
    }
}
