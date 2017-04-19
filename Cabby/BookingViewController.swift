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
    
    var origin = Location(lat: 0, long: 0, name: "")
    var destination = Location(lat: 0, long: 0, name: "")
    var trip = Trip()
    var markets: [GMSMarker] = []
    
    var polyLine = GMSPolyline()

    
    @IBOutlet weak var originTextField: TextField!
    @IBOutlet weak var destinationTextField: TextField!
    
    var selectedTextField = UITextField()
    
    var googleMapsView = GMSMapView()
    var mapView = GMSMapView.map(withFrame: .zero, camera: GMSCameraPosition())

    @IBOutlet weak var viewForMapView: UIView!
    var locationManager = CLLocationManager()



    @IBOutlet weak var accountBarButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        markets = [GMSMarker(), GMSMarker()]
        trip.origin = origin
        trip.destination = destination
        setupNavigationBar()
        setupMapView()
        setupTextFieldForThisViewController()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        setupMapView()
        
    }
    @IBAction func leftSideMenuPressed() {
        self.sideViewController()!.toogleLeftViewController()
    }
    
    @IBAction func rightSideMenuPressed() {
        if self.sideViewController()!.rightViewControllerVisible {
            self.sideViewController()!.hideRightViewController()
        } else {
            self.sideViewController()!.presentRightViewController(0.5, dampingRatio: 0.4, velocity: 10, options: .curveEaseIn)
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
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.googleMapsView.camera = camera
        
        self.googleMapsView.delegate = self
        self.googleMapsView.isMyLocationEnabled = true
        self.googleMapsView.settings.myLocationButton = true
        
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView

        
        viewForMapView.addSubview(mapView)
        
        mapView.snp.makeConstraints(){
            $0.size.equalTo(mapView.superview!)
            $0.center.equalTo(mapView.superview!)
        }
    }

    func textFieldDidChange()
    {
//        showAutoCompleteViewController()
    }
    func setupTextFieldForThisViewController()
    {
        textFieldForThisViewController(textField: originTextField)
        textFieldForThisViewController(textField: destinationTextField)
        
        self.setupTextField(textField: originTextField, placeHolderString: "จุดนัดพบ",placeHolderColor: .black)
        self.setupTextField(textField: destinationTextField, placeHolderString: "จุดหมายปลายทาง", placeHolderColor: .black)
        
        
    }
    func textFieldForThisViewController(textField: UITextField)
    {
        textField.layer.borderColor = UIColor.black.cgColor
        textField.addTarget(self,
                            action: #selector(BookingViewController.textFieldDidChange),
                            for: .editingChanged)
        textField.delegate = self
    }
    func showAutoCompleteViewController()
    {
        let autoCompleteViewController = GMSAutocompleteViewController()
        
        autoCompleteViewController.delegate = self
        
        self.present(autoCompleteViewController, animated: true, completion: nil)
        
        
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
            drawPath()
        }
    }
    
    func addMarker(_ location: Location)
    {
            origin = Location(lat: location.lat, long: location.long, name: location.name)
            trip.origin = origin
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
            marker.title = location.name
            // marker.snippet = "Australia"
            
            marker.map = mapView

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

        if (origin.name != "" && destination.name != "")
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
        addMarker(origin)
        addMarker(destination)
    }
}

extension BookingViewController: GMSAutocompleteViewControllerDelegate
{
    func viewController(_ viewController: GMSAutocompleteViewController,
                        didAutocompleteWith place: GMSPlace) {
        
        removeMarkerAndRoutingDirection()
        
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude
        let name = place.name
        
        let camera = GMSCameraPosition.camera(withLatitude: lat,
                                              longitude: long,
                                              zoom: 15.0)
    
        selectedTextField.text = name
        
        if (selectedTextField == originTextField)
        {
            origin.lat = lat
            origin.long = long
            origin.name = name
            trip.origin = origin
    
        }
        else if (selectedTextField == destinationTextField)
        {
            destination.lat = lat
            destination.long = long
            destination.name = name
            trip.destination = destination
        }
        if (isTripCompleted() == true)
        {
            reloadMapRoute()
        }
        
        
        
        self.googleMapsView.camera = camera
        self.dismiss(animated: true, completion: nil) // dismiss after select place
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
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
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.googleMapsView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
    }
}
