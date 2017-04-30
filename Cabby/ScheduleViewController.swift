//
//  ScheduleViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/23/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    var trips: [Trip] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trip1 = Trip()
        
        trip1.origin = Location()
        trip1.origin?.lat = 13.646307
        trip1.origin?.long = 100.680090
        trip1.origin?.name = "MOONSOON Mega Bangna"
        
        trip1.destination = Location()
        trip1.destination?.lat = 13.729646
        trip1.destination?.long = 100.773923
        trip1.destination?.name = "KMITL"
        trip1.date = "1 May 2017"
        trip1.time = "03 : 30 AM."
        
        let trip2 = Trip()
        
        trip2.origin = Location()
        trip2.origin?.lat = 13.719376
        trip2.origin?.long = 100.584698
        trip2.origin?.name = "Ekkamai"
        
        trip2.destination = Location()
        trip2.destination?.lat = 13.729646
        trip2.destination?.long = 100.773923
        trip2.destination?.name = "KMITL"
        trip2.date = "1 APRIL 2017"
        trip2.time = "02 : 15 AM."
        
        trips.append(trip1)
        trips.append(trip2)
        
        

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
        
        if section == 0
        {
            return trips.count
        }
        else
        {
            return 1
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var realCell = UICollectionViewCell()
        if (indexPath.section == 0)
        {
            
            let trip = trips[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scheduleCell", for: indexPath) as! ScheduleCollectionViewCell
            
            cell.handler = {
                self.trips.remove(at: indexPath.item)
                collectionView.reloadData()
            }
            
            cell.moreDetailHandler = {
                
                let storyBoard = UIStoryboard.init(name: "My",
                                                   bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewScheduleViewController") as! ViewScheduleViewController
                viewController.trip = trip
                
         
                
                let navigationviewController = UINavigationController(rootViewController: viewController)
                
                navigationviewController.modalTransitionStyle = .coverVertical
                self.present(navigationviewController, animated: true, completion: nil)

                
            }
            cell.origin = trip.origin?.name ?? ""
            cell.destination = trip.destination?.name ?? ""
            cell.dateAndTime = "\(trip.date) , \(trip.time)"
            
            
            
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
