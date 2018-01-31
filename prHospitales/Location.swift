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
    var longitud :Double?
    var latitud :Double?
    var locationManager : CLLocationManager!
    var completionHandler: ()->Void = {}
    
    
    
    /*
     override init() {
     
     
     super.init()
     locationManager.delegate = self
     }
     */
    func configureLocations(completion: @escaping () -> Void) {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.delegate = self
        locationManager.requestLocation()
        self.completionHandler = completion
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Entro en manejador de permisos")
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            break
        case .authorizedAlways:
            locationManager.requestLocation()
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            print("Permisos restringidos")
            
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            
            print("Permisos denegados")
            break
        default:
            break
        }
    }

    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Entro")
        if let mostRecentLocation = locations.first  {
            self.longitud = mostRecentLocation.coordinate.longitude
            self.latitud = mostRecentLocation.coordinate.latitude
            print("Posicion del usuario obtenida")
            self.completionHandler()
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

