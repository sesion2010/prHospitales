//
//  Centro.swift
//  prHospitales
//
//  Created by INFTEL 03 on 30/1/18.
//  Copyright © 2018 INFTEL 06. All rights reserved.
//

import UIKit
import os.log

class Centro: NSObject, NSCoding{
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(tipo, forKey: PropertyKey.tipo)
        aCoder.encode(nombre, forKey: PropertyKey.nombre)
        aCoder.encode(direccion, forKey: PropertyKey.direccion)
        aCoder.encode(lat, forKey: PropertyKey.lat)
        aCoder.encode(long, forKey: PropertyKey.long)
        aCoder.encode(val, forKey: PropertyKey.val)
        aCoder.encode(id, forKey: PropertyKey.id)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let tipo = aDecoder.decodeObject(forKey: PropertyKey.tipo) as? String else {
            os_log("Unable to decode the type for a Center object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        let nombre = aDecoder.decodeObject(forKey: PropertyKey.nombre) as? String
        let direccion = aDecoder.decodeObject(forKey: PropertyKey.direccion) as? String
        let lat = aDecoder.decodeObject(forKey: PropertyKey.lat) as? Float
        let long = aDecoder.decodeObject(forKey: PropertyKey.long) as? Float
        let val = aDecoder.decodeObject(forKey: PropertyKey.val) as? Float
        let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? Int
        
        // Must call designated initializer.
        self.init(ti: tipo,no:nombre!,di:direccion!,lt:lat!,lg:long!,v:val!, i: id! )
    }
    
    var tipo: String
    var nombre: String
    var direccion: String
    var lat: Float
    var long: Float
    var val: Float
    var id: Int
    
    init?(ti: String, no: String, di: String, lt: Float, lg: Float, v: Float, i: Int){
        self.tipo = ti
        self.nombre = no
        self.direccion = di
        self.lat = lt
        self.long = lg
        self.val = v
        self.id = i
    }
    
    //MARK: Properties
    struct PropertyKey{
        static let tipo="tipo"
        static let nombre = "nombre"
        static let direccion = "direccion"
        static let lat = "lat"
        static let long = "long"
        static let val = "val"
        static let id = "id"
    }
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("centros")
}

