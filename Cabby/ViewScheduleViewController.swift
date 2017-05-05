//
//  ViewScheduleViewController.swift
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


class ViewScheduleViewController: UIViewController {
    enum Container {
        case completed
        case locationed
        case none
    }
    
    @IBOutlet weak var bookingView: UIView!
    
    let googleMapAPIKey = SingletonGoogleMapAPIKey.googleMapAPIKey
    var path = GMSPath()
    var bounds = GMSCoordinateBounds()
    var showingContainer:Container = .none
    

    func hideLocationContainer()
    {
        if showingContainer == .locationed
        {
            locationedContainerView.transform = self.locationedContainerView.transform.translatedBy( x: 0.0, y: 165 )
        }
    }
    func hideDetailContainer()
    {
        if showingContainer == .completed
        {
            bookingView.transform = self.bookingView.transform.translatedBy( x: 0.0, y: 165 )
        }
    }
    @IBOutlet weak var locationedContainerView: UIView!
    

    func showLocationedContainer()
    {
        if showingContainer == .locationed
        {
            
        }
        else
        {
            hideDetailContainer()
            locationedContainerView.transform =  self.locationedContainerView.transform.translatedBy( x: 0.0, y: -165 )
            showingContainer = .locationed
            
        }
        
    }
    
    func showDetailedContainer()
    {
        if (showingContainer == .completed)
        {
            
        }
        else
        {
            hideLocationContainer()
            bookingView.transform = self.bookingView.transform.translatedBy( x: 0.0, y: -165 )
            showingContainer = .completed
        }
        
    }
    

    @IBAction func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var dateLabel: UILabel!
    var date: String {
        get { return dateLabel.text ?? "" }
        set { dateLabel.text = newValue }
    }
    @IBOutlet weak var timeLabel: UILabel!
    var time: String {
        get { return timeLabel.text ?? "" }
        set { timeLabel.text = newValue }
    }
    
    @IBOutlet weak var emergencyTelNoLabel: UILabel!
    var emergencyTelNo: String {
        get { return emergencyTelNoLabel.text ?? "" }
        set { emergencyTelNoLabel.text = newValue }
    }
    @IBOutlet weak var emergencyNameLabel: UILabel!
    var emergencyName: String {
        get { return emergencyTelNoLabel.text ?? "" }
        set { emergencyTelNoLabel.text = newValue }
    }
    
    
    var trip = Trip()
    var markers: [GMSMarker] = []
    
    var polyLine = GMSPolyline()
    
    
    @IBOutlet weak var originTextField: BlackFormTextField!
    var originName: String {
        get { return originTextField.text ?? "" }
        set { originTextField.text = newValue }
    }
    @IBOutlet weak var destinationTextField: BlackFormTextField!
    var destinationName: String {
        get { return destinationTextField.text ?? "" }
        set { destinationTextField.text = newValue }
    }
    
    
    var selectedTextField = UITextField()
    
    var googleMapsView = GMSMapView()
    var mapView = GMSMapView.map(withFrame: .zero,
                                 camera: GMSCameraPosition())
    
    @IBOutlet weak var viewForMapView: UIView!
    var locationManager = CLLocationManager()
    
    func focusMapToShowAllMarkers() {
        let myLocation: CLLocationCoordinate2D = self.markers.first!.position
        var bounds: GMSCoordinateBounds = GMSCoordinateBounds(coordinate: myLocation, coordinate: myLocation)
        
        for marker in self.markers {
            bounds = bounds.includingCoordinate(marker.position)
            self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 15.0))
        }
    }

    override func viewDidLoad() {
        showLocationedContainer()
        setupTextFieldForThisViewController()
        setupNavigationBar()
        removeMarkerAndRoutingDirection()
        originName = trip.origin?.name ?? ""
        destinationName = trip.destination?.name ?? ""
        
        setupMapView()
        addMarkers()
        
        drawPath()
        

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
        originTextField.isEnabled = false
        destinationTextField.isEnabled = false
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
            drawPath()
        }
        
    }

    
    
    func newZoom()
    {
        
        for index in 1...path.count() {
            
            bounds = bounds.includingCoordinate(path.coordinate(at: index))
        }
        mapView.animate(with: GMSCameraUpdate.fit(bounds))

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
}

extension ViewScheduleViewController: GMSAutocompleteViewControllerDelegate
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
            
            
            
        }
        else if (selectedTextField == destinationTextField)
        {
            trip.destination?.lat = place.coordinate.latitude
            trip.destination?.long = place.coordinate.longitude
            trip.destination?.name = place.name
            
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
extension ViewScheduleViewController: GMSMapViewDelegate
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



