//
//  MainViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import GoogleMaps
import SnapKit
import GooglePlaces
import Alamofire
import SwiftyJSON


class BookingViewController: UIViewController {
    
    let googleMapAPIKey = "AIzaSyAI97m4eAMhz_7-qIoVWo7b-0cA4cnfNic"
    var path = GMSMutablePath()
    var bounds = GMSCoordinateBounds()


    
    var trip = Trip()
    var markers: [GMSMarker] = []
    
    var polyLine = GMSPolyline()

    
    @IBOutlet weak var originTextField: TextField!
    @IBOutlet weak var destinationTextField: TextField!
    
    var selectedTextField = UITextField()
    
    var googleMapsView = GMSMapView()
    var mapView = GMSMapView.map(withFrame: .zero,
                                 camera: GMSCameraPosition())

    @IBOutlet weak var viewForMapView: UIView!
    var locationManager = CLLocationManager()



    @IBOutlet weak var accountBarButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        
  
        
        markers = [GMSMarker(), GMSMarker()]
        trip.origin = Location()
        trip.destination = Location()
        setupNavigationBar()
        setupTextFieldForThisViewController()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()

        
        
    }

    @IBAction func leftSideMenuPressed() {
        self.sideViewController()!.toogleLeftViewController()
    }
    
    @IBAction func rightSideMenuPressed() {
        if self.sideViewController()!.rightViewControllerVisible {
            self.sideViewController()!.hideRightViewController()
        } else {
            self.sideViewController()!.presentRightViewController(0.5,
                                                                  dampingRatio: 0.4,
                                                                  velocity: 10,
                                                                  options: .curveEaseIn)
        }
    }
    
    func setupNavigationBar ()
    {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    override var prefersStatusBarHidden : Bool {
        return true
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


    func setupTextFieldForThisViewController()
    {
        
        originTextField.text = ""
        destinationTextField.text = ""
        originTextField.padding = UIEdgeInsets(top: 8, left: 15, bottom: 0, right: 15)
        destinationTextField.padding = UIEdgeInsets(top: 8, left: 15, bottom: 0, right: 15)

        
        self.setupTextField(textField: originTextField,
                            placeHolderString: "จุดนัดพบ",
                            placeHolderColor: .black,
                            borderColor: .black, borderWidth: 1.0)
        
        self.setupTextField(textField: destinationTextField,
                            placeHolderString: "จุดหมายปลายทาง",
                            placeHolderColor: .black,
                            borderColor: .black, borderWidth: 1.0)
        
        destinationTextField.delegate = self
        originTextField.delegate = self
        
        
    }

    func showAutoCompleteViewController()
    {
        let autoCompleteViewController = GMSAutocompleteViewController()
        

        
        autoCompleteViewController.delegate = self
        
        self.present(autoCompleteViewController,
                     animated: true,
                     completion: nil)
    }
    
    func removeMarkerAndRoutingDirection ()
    {
        mapView.clear()
    }
    func reloadMapRoute()
    {
        
        if (originTextField.text != "" && destinationTextField.text != "")
        {
            addMarkers()
            newZoom()
//            focusMapToShowAllMarkers()
            drawPath()
        }
        
    }
    func focusMapToShowAllMarkers() {
        let myLocation: CLLocationCoordinate2D = self.markers.first!.position
        var bounds: GMSCoordinateBounds = GMSCoordinateBounds(coordinate: myLocation, coordinate: myLocation)
        
        for marker in self.markers {
            bounds = bounds.includingCoordinate(marker.position)
            self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 15.0))
        }
    }
    
    
    func newZoom()
    {
        let update = GMSCameraUpdate.fit(bounds,
                                               withPadding: 15)
        mapView.animate(with: update)
    }
    
    
    func addMarker(_ location: Location)
    {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: location.lat,
                                                     longitude: location.long)
            marker.title = location.name
            marker.map = mapView
            bounds = bounds.includingCoordinate(marker.position)

    }
    
    func drawPath()
    {
        let originCoordinate = "\((trip.origin?.lat)!),\((trip.origin?.long)!)"
        let destinationCoordinate = "\((trip.destination?.lat)!),\((trip.destination?.long)!)"
    
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(originCoordinate)&destination=\(destinationCoordinate)&mode=driving&key=\(googleMapAPIKey)"
        
        Alamofire.request(url).responseJSON { response in

            print(response)   // result of response serialization
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                self.polyLine = GMSPolyline.init(path: path)
                self.polyLine.strokeWidth = 3.0
                self.polyLine.strokeColor = #colorLiteral(red: 0.3019607843, green: 0.6274509804, blue: 0.9960784314, alpha: 1)
                self.polyLine.map = self.mapView
            }
        }
    }
    func isTripCompleted()-> Bool
    {

        if (trip.origin?.name != "" && trip.destination?.name != "")
        {
            return true
        }
        else
        {
            return false
        }
    }
    func addMarkers()
    {
        addMarker(trip.origin!)
        addMarker(trip.destination!)
    }
}

extension BookingViewController: GMSAutocompleteViewControllerDelegate
{
    func viewController(_ viewController: GMSAutocompleteViewController,
                        didAutocompleteWith place: GMSPlace) {
        

        
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude,
                                              longitude: place.coordinate.longitude,
                                              zoom: 15.0)
    
        selectedTextField.text = place.name
        
        if (selectedTextField == originTextField)
        {
            trip.origin?.lat = place.coordinate.latitude
            trip.origin?.long = place.coordinate.longitude
            trip.origin?.name = place.name
            
            print(trip)
    
        }
        else if (selectedTextField == destinationTextField)
        {
            trip.destination?.lat = place.coordinate.latitude
            trip.destination?.long = place.coordinate.longitude
            trip.destination?.name = place.name
            print(trip)
        }
        if (isTripCompleted() == true)
        {
            
            removeMarkerAndRoutingDirection()
            reloadMapRoute()
        }
        
        
        
        self.googleMapsView.camera = camera
        self.dismiss(animated: true, completion: nil) // dismiss after select place
    }
    func viewController(_ viewController: GMSAutocompleteViewController,
                        didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")

    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil) // when cancel search

    }
}
extension BookingViewController: GMSMapViewDelegate
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
extension BookingViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTextField = textField
        showAutoCompleteViewController()
    }
}
extension BookingViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while get location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!,
                                              longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.googleMapsView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        setupMapView()
        
    }
}

