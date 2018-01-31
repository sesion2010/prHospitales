//
//  CentrosFachada.swift
//  prHospitales
//
//  Created by INFTEL 03 on 30/1/18.
//  Copyright © 2018 INFTEL 06. All rights reserved.
//

import UIKit

class CentrosFachada: NSObject {
    
    var items = [Centro]()
    
    func loadItems(completion: @escaping (_ list: [Centro]) -> Void){
        print("Entra en loadItems")
        //let todoEndpoint: String = "https://pokeapi.co/api/v2/pokemon"
        //http://192.168.183.43:8080/hospital/webresources/entity.hospital/bytype/Hospital
        let todoEndpoint: String = "http://192.168.183.43:8080/hospital/webresources/entity.hospital/bytype/Hospital"
        guard let url = URL(string: todoEndpoint) else{
            print("Error: cannot create URL")
            return
        }
        //creamos una sesion para traer la info
        let urlRquest = URLRequest(url: url)
        //set up session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        //make request
        let task = session.dataTask(with: urlRquest) { (data, response, error) in
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error ?? "error")
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                guard let listaCentros = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String: Any]] else {
                    print("error trying to convert data to JSON")
                    
                    return
                }
                for item in listaCentros{
                
                    guard let centroTipo = item["tipo"] as? String else {
                        print("Could not get todo title from JSON")
                        return
                    }
                    guard let centroNombre = item["nombre"] as? String else {
                        print("Could not get todo title from JSON")
                        return
                    }
                    guard let centroDireccion = item["direccion"] as? String else {
                        print("Could not get todo title from JSON")
                        return
                    }
                    guard let centroLat = item["lat"] as? Float else {
                        print("Could not get todo title from JSON")
                        return
                    }
                    guard let centroLong = item["lon"] as? Float else {
                        print("Could not get todo title from JSON")
                        return
                    }
                    guard let centroValoracion = item["valoracion"] as? Float else {
                        print("Could not get todo title from JSON")
                        return
                    }
                    guard let centroId = item["id"] as? Int else {
                        print("Could not get todo title from JSON")
                        return
                    }
     
                    let newCentro = Centro(ti: centroTipo, no: centroNombre, di: centroDireccion, lt: centroLat, lg: centroLong, v: centroValoracion, i: centroId)
                    self.items.append(newCentro!)
                    print(newCentro?.nombre)
                }
 
                completion(self.items)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
        
    }
}
