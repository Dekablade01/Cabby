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
    
    var origin = Location()
    var destination = Location()
    var point: [Location] = []
    var markets: [GMSMarker] = []

    
    @IBOutlet weak var originTextField: TextField!
    @IBOutlet weak var destinationTextField: TextField!
    
    var selectedTextField = UITextField()
    
    var googleMapsView = GMSMapView()
    var mapView = GMSMapView.map(withFrame: .zero, camera: GMSCameraPosition())

    @IBOutlet weak var viewForMapView: UIView!
    var locationManager = CLLocationManager()



    @IBOutlet weak var accountBarButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        point = [origin, destination]
        markets = [GMSMarker(), GMSMarker()]
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
    func reloadMapRoute()
    {
        
        if (originTextField.text != "" && destinationTextField.text != "")
        {
            path.removeAllCoordinates()
            drawPath()
            
        }
    }
    
    func drawPath()
    {
        let origin = "\(point.first?.lat),\(point.first?.long)"
        let destination = "\(point.last?.lat),\(point.last?.long)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(googleMapAPIKey)"
        
        Alamofire.request(url).responseJSON { response in
            print(response.request ?? "")  // original URL request
            print(response.response ?? "") // HTTP URL response
            print(response.data ?? "")     // server data
            print(response.result)   // result of response serialization
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.map = self.mapView
            }
        }
    }
}

extension BookingViewController: GMSAutocompleteViewControllerDelegate
{
    func viewController(_ viewController: GMSAutocompleteViewController,
                        didAutocompleteWith place: GMSPlace) {
        
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: lat,
                                              longitude: long,
                                              zoom: 15.0)
    
        selectedTextField.text = place.name
        
        if (selectedTextField == originTextField)
        {
           origin = Location(lat: lat, long: long)
            point[0] = origin
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            marker.title = place.name
//            marker.snippet = "Australia"
            markets[0] = marker
            
            markets[0].map = mapView
            
            reloadMapRoute()
            
        }
        else if (selectedTextField == destinationTextField)
        {
            destination = Location(lat: lat, long: long)
            point[1] = destination
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            marker.title = place.name
            //            marker.snippet = "Australia"
            markets[1] = marker
            
            markets[1].map = mapView
            
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
