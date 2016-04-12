//
//  MapViewController.swift
//  NoleFit
//
//  Created by Lazaro Romero on 4/11/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var matchingItems: [MKMapItem] = [MKMapItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 16)!]
        self.navigationItem.title = "Find A Gym"
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.mapView.showsUserLocation = true
        self.locationManager.startUpdatingLocation()
        performSearch()
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    func performSearch() {
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Gym"
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) in
            if error != nil {
                print("Error occured in search: \(error?.localizedDescription)")
            } else {
                for item in (response?.mapItems)! as [MKMapItem] {
                    //print("Name = \(item.name)")
                    //print("Phone = \(item.phoneNumber)")
                    self.matchingItems.append(item as MKMapItem)
                    //print("Matching items = \(self.matchingItems.count)")
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
}