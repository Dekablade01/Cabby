//
//  EmergenyCallListViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/23/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class EmergenyCallListViewController: UIViewController {
    
    var callers: [Caller] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let call1 = Caller(phone: "+6680-495-1999", name: "JOSEPHINE R.", status: "เพื่อน")
        let call2 = Caller(phone: "+6680-495-1833", name: "MADDI B.", status: "เพื่อน")
        
        callers.append(call1)
        callers.append(call2)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closeButtonHandler(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }


}
extension EmergenyCallListViewController: UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return callers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EmergencyCollectionViewCell
        let caller = callers[indexPath.item]
        
        cell?.phoneNumberLabel.text = caller.phoneNumber
        cell?.nameLabel.text = caller.name
        
        return cell!
    }
}

