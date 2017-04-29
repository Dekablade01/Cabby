//
//  ScheduleViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/23/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension ScheduleViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var realCell = UICollectionViewCell()
        if (indexPath.section == 0)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scheduleCell", for: indexPath) as! ScheduleCollectionViewCell
            
            realCell = cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath)
            realCell = cell
        }
        return realCell
    }
}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        
        var size = CGSize(width: width, height: width*315/610)
        
        if indexPath.section == 1
        {
            size = CGSize(width: collectionView.bounds.width, height: 50)
        }
        return size
    }
}
