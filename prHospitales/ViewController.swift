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
        nuevaVentana(tipo: 2);
    }
    
    func nuevaVentana(tipo: Int){
        let location = Location()
        location.start()
        print(tipo)
        let centrosFacade = CentrosFachada()
        centrosFacade.loadItems() {(list) in
            for poke in list {
            
                    let distancia = location.getDistance(lat2: Double(poke.lat), long2: Double(poke.long))
                    print(String(distancia))
                
                //calcular 5 cercanos
                //calcularDistancia(poke)
            }
        }
        
    }
}

