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
    var distanciasHandler: ()->Void = {}
    var mostrarPopUp: ()->Void = {}
    
    
    
    /*
     override init() {
     
     
     super.init()
     locationManager.delegate = self
     }
     */
    func requestLocation(calcularDistanciasAcentros: @escaping () -> Void) {
        DispatchQueue.main.async{
            self.locationManager = CLLocationManager()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = kCLDistanceFilterNone
            self.locationManager.delegate = self
            self.distanciasHandler = calcularDistanciasAcentros
            self.enableLocationServices(status: CLLocationManager.authorizationStatus())
        }
        
    }
    
    func enableLocationServices(status: CLAuthorizationStatus) {
        
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
            print("Denegados")
            self.mostrarPopUp()
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Entro en manejador de permisos")
        enableLocationServices(status: status)
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let mostRecentLocation = locations.last  {
            self.longitud = mostRecentLocation.coordinate.longitude
            self.latitud = mostRecentLocation.coordinate.latitude
            self.distanciasHandler()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         locationManager.stopUpdatingLocation()
    }
    
    
    func  getDistance( lat2 :Double, long2 : Double) -> Double{
        let coordinate0 = CLLocation(latitude: self.latitud!, longitude: self.longitud!)
        let coordinate1 = CLLocation(latitude: lat2, longitude:long2)
        let distanceInMeters = coordinate0.distance(from: coordinate1) // result is in meters
        return distanceInMeters
    }
}

