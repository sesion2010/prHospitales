//
//  Centro.swift
//  prHospitales
//
//  Created by INFTEL 03 on 30/1/18.
//  Copyright © 2018 INFTEL 06. All rights reserved.
//

import UIKit

class Centro{
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
    
}
