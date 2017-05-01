//
//  BookedViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 5/1/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import GoogleMaps
import SnapKit
import GooglePlaces
import Alamofire
import SwiftyJSON

class BookedViewController: UIViewController {

    @IBOutlet weak var footerView: UIView!
    var markers: [GMSMarker] = []
    let googleMapAPIKey = SingletonGoogleMapAPIKey.googleMapAPIKey

    var path = GMSPath()
    var polyLine = GMSPolyline()
    var bounds = GMSCoordinateBounds()

    @IBOutlet weak var originTextField: TextField!
    var originName: String {
        set { originTextField.text = newValue }
        get { return originTextField.text ?? "" }
    }
    var locationManager = CLLocationManager()

    @IBOutlet weak var viewForMapView: UIView!

    
    @IBOutlet weak var destinationTextField: TextField!
    var destinationName: String {
        set { destinationTextField.text = newValue }
        get { return destinationTextField.text ?? "" }
    }
    
    var googleMapsView = GMSMapView()
    var mapView = GMSMapView.map(withFrame: .zero,
                                 camera: GMSCameraPosition())
    
    var trip:Trip { return SingletonTrip.trip }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNotificationViewController()
        
        self.becomeFirstResponder()


    }
    override var canBecomeFirstResponder: Bool { return true } 
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake
        {
            let storyBoard = UIStoryboard(name: "My", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
            
            self.present(viewController, animated: true, completion: nil)
            
        }
    }
    
    func setupViewController()
    {
        footerView.backgroundColor = .white
        originName = trip.origin?.name ?? ""
        destinationName = trip.destination?.name ?? ""
        setupMapView()
        removeMarkerAndRoutingDirection()
        addMarkers()
        drawPath()
    }
    
    func createNotificationViewController()
    {
        let storyBoard = UIStoryboard.init(name: "My", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        
        viewController.dismissHandler = {
            
            self.setupViewController()
        }
        viewController.modalTransitionStyle = .coverVertical
        
        self.present(viewController, animated: true , completion: nil)
    }
    
    func drawPath()
    {
        let originCoordinate = "\((trip.origin?.lat)!),\((trip.origin?.long)!)"
        let destinationCoordinate = "\((trip.destination?.lat)!),\((trip.destination?.long)!)"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(originCoordinate)&destination=\(destinationCoordinate)&mode=driving&key=\(googleMapAPIKey)"
        
        Alamofire.request(url).responseJSON { response in
            
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                self.path = path ?? GMSPath()
                self.polyLine = GMSPolyline.init(path: path)
                self.polyLine.strokeWidth = 3.0
                self.polyLine.strokeColor = #colorLiteral(red: 0.3019607843, green: 0.6274509804, blue: 0.9960784314, alpha: 1)
                self.polyLine.map = self.mapView
            }
            self.newZoom()
        }
    }

    
    func addMarkers()
    {
        addMarker(trip.origin!)
        addMarker(trip.destination!)
    }
    
    func addMarker(_ location: Location)
    {
        let position = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
        
        let marker = GMSMarker(position: position)
        marker.title = location.name
        marker.map = mapView
        markers.append(marker)
        
        
        bounds = bounds.includingCoordinate(marker.position)
    }
    
    func setupMapView()
    {
        let camera = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!,
                                              longitude: (locationManager.location?.coordinate.longitude)!, zoom: 15)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.googleMapsView.camera = camera
        
        self.googleMapsView.delegate = self
        self.googleMapsView.isMyLocationEnabled = true
        self.googleMapsView.settings.myLocationButton = true
        
        
        viewForMapView.addSubview(mapView)
        
        mapView.snp.makeConstraints(){
            $0.size.equalTo(mapView.superview!)
            $0.center.equalTo(mapView.superview!)
        }
    }
    
    func removeMarkerAndRoutingDirection ()
    {
        mapView.clear()
    }
    func newZoom()
    {
        
        for index in 1...path.count() {
            
            bounds = bounds.includingCoordinate(path.coordinate(at: index))
        }
        mapView.animate(with: GMSCameraUpdate.fit(bounds))
        
    }

}

extension BookedViewController: GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.googleMapsView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
        self.googleMapsView.isMyLocationEnabled = true
        if (gesture) {
            mapView.selectedMarker = nil
        }
        
    }
}

