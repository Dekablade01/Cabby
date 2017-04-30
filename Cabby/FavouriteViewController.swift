//
//  FavouriteViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/29/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    var trips: [Trip] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        var trip1 = Trip()
        
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
        
        var trip2 = Trip()
        
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


extension FavouriteViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavouriteCollectionViewCell
        let trip = trips[indexPath.item]
        cell.originName = trip.origin?.name ?? ""
        cell.destinationName = trip.destination?.name ?? ""
        
        cell.bookHandler = {
            
            let storyboard = UIStoryboard.init(name: "My", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "FavouriteBookingViewController") as! FavouriteBookingViewController
            
            viewController.trip = trip
            
            viewController.modalTransitionStyle = .coverVertical
            
            self.present(viewController, animated: true, completion: nil)
            
        }
        cell.removeHandler = {
            self.trips.remove(at: indexPath.item)
            collectionView.reloadData()
        }
        
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
