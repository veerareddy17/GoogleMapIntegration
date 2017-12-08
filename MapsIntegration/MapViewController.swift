//
//  MapViewController.swift
//  MapsIntegration
//
//  Created by Vera on 12/8/17.
//  Copyright © 2017 Vera. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class MapViewController: UIViewController,UISearchBarDelegate {
    var placeArray = [GMSPlace]()
 
    @IBOutlet weak var googleMapView: GMSMapView!
    var marker = GMSMarker()
    var zoom: Float = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftBarButton = UIBarButtonItem(title: "View", style: .done, target: self, action: #selector(self.viewTapped))
       navigationItem.leftBarButtonItem = leftBarButton
       
        self.view.addSubview(self.googleMapView)
    }
    @objc func viewTapped(){
        for i in 0..<placeArray.count{
           let camera = GMSCameraPosition.camera(withLatitude: placeArray[i].coordinate.latitude, longitude: placeArray[i].coordinate.longitude, zoom: zoom)
            self.googleMapView.camera = camera
             marker = GMSMarker(position: CLLocationCoordinate2D(latitude: placeArray[i].coordinate.longitude, longitude: placeArray[i].coordinate.longitude))
            marker.title = "\(placeArray[i].name)"
            marker.snippet = "\(String(describing: placeArray[i].formattedAddress))"
            marker.map = self.googleMapView
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        self.googleMapView = GMSMapView(frame: self.mapContainerView.frame)
//        self.view.addSubview(self.googleMapView!)
//       
      }
    @IBAction func btnZoomIn(_ sender: Any) {
        zoom = zoom + 1
        self.googleMapView.animate(toZoom: zoom)
    }
    
    @IBAction func btnZoomOut(_ sender: Any) {
        zoom = zoom - 1
        self.googleMapView.animate(toZoom: zoom)
    }
@IBAction func searchAddressBar(_ sender: UIBarButtonItem) {

    let autocompleteController = GMSAutocompleteViewController()
    autocompleteController.delegate = self
    present(autocompleteController, animated: true, completion: nil)
    }
}
    

extension MapViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        self.placeArray.append(place)
        print("Place Coordinates: \(place.coordinate)")
        print("Place address: \(String(describing: place.formattedAddress!))")
        print("Place attributions: \(String(describing: place.attributions))")
        dismiss(animated: true, completion: nil)
        let camera = GMSCameraPosition.camera(withLatitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude), zoom: 16.9)
        self.googleMapView.camera = camera
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude)))
        
        marker.snippet = "\(String(describing: place.formattedAddress!))"
        marker.map = self.googleMapView
       
        marker.title = "\(String(describing: place.name))"
        print(self.placeArray.count)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}

