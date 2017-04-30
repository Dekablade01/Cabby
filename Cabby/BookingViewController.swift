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
    enum Container {
        case blank
        case locationed
        case completed
        case none
    }
    
    @IBAction func openSideBar(_ sender: Any) {
        self.sideViewController()!.toogleLeftViewController()
    }
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var locationedContainerView: UIView!
    let googleMapAPIKey = "AIzaSyA37XnM5uAmC2XBVGfhCHCe3ZpW0tdKUxg"
    var isAddedConstraintForDetailedContainerView = false
    var path = GMSMutablePath()
    var bounds = GMSCoordinateBounds()
    var showingContainer:Container = .none
    
    @IBOutlet weak var blankBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailedBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var locationedBottomConstraint: NSLayoutConstraint!
    var setDate = false {
        didSet {
            if (setEmergency == true && setDate == true)
            {
                hideLocationContainer()
                showDetailedContainer()
            }
        }
    }
    var setEmergency = false {
        didSet {
            if (setEmergency == true && setDate == true)
            {
                hideLocationContainer()
                showDetailedContainer()
            }
            
        }
    }
    func hideBlankContainer()
    {
        if showingContainer == .blank
        {
            blankBookingView.transform = self.blankBookingView.transform.translatedBy( x: 0.0, y: 165 )
        }
    }
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
            detailedBookingView.transform = self.detailedBookingView.transform.translatedBy( x: 0.0, y: 165 )
        }
    }
    
    func showBlankContainer()
    {
        if showingContainer == .blank
        {
            
        }
        else
        {
            hideDetailContainer()
            hideLocationContainer()
            
            blankBookingView.transform = self.blankBookingView.transform.translatedBy( x: 0.0, y: -165 )
            showingContainer = .blank
        }
        
    }
    func showLocationedContainer()
    {
        if showingContainer == .locationed
        {
            
        }
        else
        {
            hideBlankContainer()
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
            hideBlankContainer()
            hideLocationContainer()
            detailedBookingView.transform = self.detailedBookingView.transform.translatedBy( x: 0.0, y: -165 )
            showingContainer = .completed
        }

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
    
    @IBOutlet weak var detailedBookingView: UIView!
    
    @IBOutlet weak var blankBookingView: UIView!
    var trip = Trip()
    var markers: [GMSMarker] = []
    
    var polyLine = GMSPolyline()
    
    
    @IBOutlet weak var originTextField: TextField!
    var origin: String {
        get { return originTextField.text ?? "" }
        set { originTextField.text = newValue }
    }
    @IBOutlet weak var destinationTextField: TextField!
    var destination: String {
        get { return destinationTextField.text ?? "" }
        set { destinationTextField.text = newValue }
    }
    
    
    var selectedTextField = UITextField()
    
    var googleMapsView = GMSMapView()
    var mapView = GMSMapView.map(withFrame: .zero,
                                 camera: GMSCameraPosition())
    
    @IBOutlet weak var viewForMapView: UIView!
    var locationManager = CLLocationManager()
    
    
    
    @IBOutlet weak var accountBarButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        showBlankContainer()
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
    
    @IBAction func clearLocation(_ sender: UIButton)
    {
        origin = ""
        destination = ""
        setDate = false
        setEmergency = false
        removeMarkerAndRoutingDirection()
        showBlankContainer()
        
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
        print(url)
        
        Alamofire.request(url).responseJSON { response in
            
            
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
    @IBAction func showPicker(_ sender: UIButton) {
        
        if (origin != "" && destination != "")
        {
            let storyBoard = UIStoryboard(name: "My", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
            
            viewController.handler = { date, time in
                self.date = date
                self.time = time
                
            }
            viewController.dismissHandler = {
                self.setDate = true
                if (self.setEmergency == false)
                {
                    self.showEmergency(UIButton())
                }
            }
            
            viewController.modalTransitionStyle = .coverVertical
            self.present(viewController, animated: true, completion: nil)
        }
    }
    @IBAction func showEmergency(_ sender: UIButton)
    {
        if (origin != "" && destination != "")
        {
            let storyBoard = UIStoryboard(name: "My", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "EmergencyViewController") as! EmergencyViewController
            viewController.handler = { caller in
                self.emergencyName = caller.name
                self.emergencyTelNo = caller.phoneNumber
                
            }
            viewController.dismissHandler = {
                
                self.setEmergency = true
                if (self.setDate == false)
                {
                    self.showPicker(UIButton())
                }
            }
            viewController.modalTransitionStyle = .coverVertical
            self.present(viewController, animated: true, completion: nil)
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
            
    
            
        }
        else if (selectedTextField == destinationTextField)
        {
            trip.destination?.lat = place.coordinate.latitude
            trip.destination?.long = place.coordinate.longitude
            trip.destination?.name = place.name
         
        }
        if (isTripCompleted() == true)
        {
            
            removeMarkerAndRoutingDirection()
            reloadMapRoute()
        }
        
        if (origin != "" && destination != "" && showingContainer == .blank)
        {
            showLocationedContainer()
        }
        else if (origin != "" && destination != "" && showingContainer == .completed){
            
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

