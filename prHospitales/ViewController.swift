//
//  ViewController.swift
//  prHospitales
//
//  Created by INFTEL 06 on 29/1/18.
//  Copyright © 2018 INFTEL 06. All rights reserved.
//

import UIKit
import QuartzCore
class ViewController: UIViewController {
    
    @IBOutlet weak var buttonHospital: UIButton!
    @IBOutlet weak var buttonAmbulatorio: UIButton!
    @IBOutlet weak var buttonUrgencias: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    var location = Location()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo.jpg")!)
        buttonHospital.layer.cornerRadius = 5
        buttonAmbulatorio.layer.cornerRadius = 5
        buttonUrgencias.layer.cornerRadius = 5
        labelTitle.layer.masksToBounds = true
        labelTitle.layer.cornerRadius = 5
        labelTitle.clipsToBounds = true
        labelTitle.layer.borderWidth = 2
        labelTitle.textColor = UIColor.white
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonHospital(_ sender: UIButton) {
        nuevaVentana(tipo: 0);
    }
    
    @IBAction func buttonAmbulatorio(_ sender: UIButton) {
        nuevaVentana(tipo: 1);
    }
    
    @IBAction func buttonUrgencias(_ sender: UIButton) {
        nuevaVentana(tipo: 2)    }
    
    func nuevaVentana(tipo: Int){
        location.configureLocations(){ () in
            print(tipo)
            var centros :[CentroDistancia] = []
            let centrosFacade = CentrosFachada()
            centrosFacade.loadItems() {(list) in
                print("calculo distancias")
                for poke in list {
                    let distancia = self.location.getDistance(lat2: Double(poke.lat), long2: Double(poke.long))
                    poke.distancia = distancia
                    centros.append(CentroDistancia(c: poke,distancia: distancia)!)
                    centros.sort(by:self.sorterForDistancia)
                    print(String(distancia))
                }
            }
        }
        
    }
    func sorterForDistancia(this:CentroDistancia, that:CentroDistancia) -> Bool {
        return (this.distancia < that.distancia)
    }
}

