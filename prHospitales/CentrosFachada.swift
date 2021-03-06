//
//  CentrosFachada.swift
//  prHospitales
//
//  Created by INFTEL 03 on 30/1/18.
//  Copyright © 2018 INFTEL 06. All rights reserved.
//

import UIKit
import os.log


class CentrosFachada: NSObject {
    
    var allItems = [Centro]()
    var listaCentros = [CentroDistancia]()
    let MaximoElementos = 5

    func buscarCentrosCercanos(location :Location,tipoCentro:  String,devolverLista: @escaping ([CentroDistancia]) -> Void){
        self.listaCentros.removeAll()
        self.allItems.removeAll()
        if let centrosGuardados = cargarCentros(){
            for item in centrosGuardados {
                if(item.tipo == tipoCentro){
                    allItems.append(item)
                }
            }
            self.calcularDistancias(tipo: tipoCentro, location: location, devolverLista:devolverLista)
        }else{
            self.loadItemsServer(tipoCentro: tipoCentro){
                self.calcularDistancias(tipo: tipoCentro,location: location, devolverLista:devolverLista)
            }
        }
    }
    
    
    private func calcularDistancias(tipo: String, location :Location,devolverLista: @escaping ([CentroDistancia]) -> Void){
        location.requestLocation{
            for hosp in self.allItems {
                if(hosp.tipo == tipo){
                    let distancia = location.getDistance(lat2: Double(hosp.lat), long2: Double(hosp.long))
                    self.listaCentros.append(CentroDistancia(c: hosp,distancia: distancia)!)
                    self.listaCentros.sort(by: { (this, that) in return (this.distancia < that.distancia) } )
                    print(String(distancia))
                }
            }
            var elements = self.listaCentros.count
            if(elements >= self.MaximoElementos){
                elements = self.MaximoElementos
            }
            self.listaCentros = Array(self.listaCentros[0..<elements])
            devolverLista(self.listaCentros)
        }
        
    }
    
    private func loadItemsServer(tipoCentro :String, obtenerDistancias: @escaping () -> Void){
       
        let todoEndpoint: String = "http://192.168.183.43:8080/hospital/webresources/entity.hospital/bytype/" + tipoCentro
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
                    self.allItems.append(newCentro!)
                }
                obtenerDistancias()
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    
    //Persistencia
    private func guardarCentro() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(allItems, toFile: Centro.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Centers successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save centers...", log: OSLog.default, type: .error)
        }
    }
    
    private func cargarCentros() -> [Centro]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Centro.ArchiveURL.path) as? [Centro]
    }
}
