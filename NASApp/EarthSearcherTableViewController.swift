//
//  EarthSearcherTableViewController.swift
//  NASApp
//
//  Created by Ty Schenk on 9/20/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit
import MapKit

class EarthSearcherTableViewController: UITableViewController, UISearchBarDelegate, MKMapViewDelegate, UISearchResultsUpdating {
    
    var searchController: UISearchController!
    let locationManager = LocationManager()
    var locations: [MKMapItem] = []
    var earthLocationData: EarthLocationData?
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "CurrentLocation"), style: .plain, target: self, action: #selector(zoomToCurrentLocation))
        
        setupController()
    }

    func setupController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Search or Enter Address"
        searchController.searchBar.showsCancelButton = true
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
    }
    
    func dataUnavailable() {
        showAlert(title: "Pulling Data", message: "Satellites Unavailable, retry in a moment!")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let location = locations[indexPath.row].placemark
        cell.textLabel?.text = location.name
        cell.detailTextLabel?.text = locationManager.parseAddress(location: location)
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchController.searchBar.endEditing(true)
        
        let selectedLocation = locations[indexPath.row].placemark
        locationManager.dropPinZoomIn(placemark: selectedLocation, mapView: self.mapView)
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        self.getLocations(forSearchString: text)
    }
    
    fileprivate func getLocations(forSearchString searchString: String) {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchString
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard let response = response else { return }
            self.locations = response.mapItems
            self.tableView.reloadData()
        }
    }
    
    @objc func zoomToCurrentLocation() {
        //Clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapView.userLocation.coordinate
        mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegionMake(mapView.userLocation.coordinate, span)
        mapView.setRegion(region, animated: true)
        
        let location = CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
        mapView.add(MKCircle(center: location.coordinate, radius: 50))
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.lineWidth = 2.0
            circleRenderer.strokeColor = .red
            circleRenderer.fillColor = UIColor.red.withAlphaComponent(0.4)
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }

}
