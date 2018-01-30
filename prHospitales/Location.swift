//
//  Location.swift
//  prHospitales
//
//  Created by INFTEL 03 on 30/1/18.
//  Copyright © 2018 INFTEL 06. All rights reserved.
//

import UIKit

import UIKit
import CoreLocation

class Location: NSObject,CLLocationManagerDelegate {
    static let shared = Location()
    var longitud :Double?
    var latitud :Double?
    let locationManager : CLLocationManager
    override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        super.init()
        locationManager.delegate = self
    }
    
    func start() {
        print("Pedir permiso")
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Entro")
        if let mostRecentLocation = locations.first  {
            self.longitud = mostRecentLocation.coordinate.longitude
            self.latitud = mostRecentLocation.coordinate.latitude
            print("Posicion del usuario obtenida")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        locationManager.stopUpdatingLocation()
    }
    
    
     func  getDistance( lat2 :Double, long2 : Double) -> Double{
        let coordinate0 = CLLocation(latitude: self.latitud!, longitude: self.longitud!)
        let coordinate1 = CLLocation(latitude: lat2, longitude:long2)
        let distanceInMeters = coordinate0.distance(from: coordinate1) // result is in meters
        return distanceInMeters
    }
}

