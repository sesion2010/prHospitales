//
//  CentroDistancia.swift
//  prHospitales
//
//  Created by INFTEL 03 on 30/1/18.
//  Copyright © 2018 INFTEL 06. All rights reserved.
//

import UIKit

class CentroDistancia: NSObject {
    
    var distancia: Double
    var centro: Centro
    
    init?(c: Centro, distancia: Double){
        self.centro = c
        self.distancia = distancia
        
    }

}
