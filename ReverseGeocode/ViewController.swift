//
//  ViewController.swift
//  ReverseGeocode
//
//  Created by Kyle Goslan on 24/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var localityLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var location = CLLocation(latitude: 37.33233141, longitude: -122.0312186)
        reverseGeocode(location)
    }

    func reverseGeocode(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            if placemarks.count > 0 {
                if let placemark = placemarks.last as? CLPlacemark {
                    self.updateView(placemark)
                }
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func updateView(placemark: CLPlacemark) {
        countryLabel.text = placemark.country
        localityLabel.text = placemark.administrativeArea + " " + placemark.locality
        zipLabel.text = placemark.postalCode
    }

}

