//
//  ViewController.swift
//  prHospitales
//
//  Created by INFTEL 06 on 29/1/18.
//  Copyright © 2018 INFTEL 06. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("prueba")
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
        print(tipo)
    }
}

