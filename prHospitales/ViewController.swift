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
    let maxCentros = 5
    var listaCentros = [CentroDistancia]()
    var location = Location()
    let centrosFachada = CentrosFachada()
    var tipoCentro = AppDelegate.TipoCentro.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo.jpeg")!)
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
        self.listaCentros.removeAll()
        centrosFachada.buscarCentrosCercanos(location:self.location,tipoCentro: String(describing: self.tipoCentro.Hospital)){ (aListaCentros) in
            self.listaCentros = aListaCentros
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "nav", sender: sender)
            }
        }
    }
    
    @IBAction func buttonAmbulatorio(_ sender: UIButton) {
        self.listaCentros.removeAll()
        centrosFachada.buscarCentrosCercanos(location:self.location,tipoCentro: String(describing: self.tipoCentro.Ambulatorio)){ (aListaCentros) in
            self.listaCentros = aListaCentros
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "nav", sender: sender)
            }
        }
    }
    
    @IBAction func buttonUrgencias(_ sender: UIButton) {
        self.listaCentros.removeAll()
        centrosFachada.buscarCentrosCercanos(location:self.location,tipoCentro: String(describing: self.tipoCentro.Urgencias)){ (aListaCentros) in
            self.listaCentros = aListaCentros
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "nav", sender: sender)
            }
        }
    }
    
  

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "nav"{
            guard let navViewController = segue.destination as? UINavigationController else {
                fatalError("Unexpected Error \(segue.destination)")
            }
            guard let hospitalViewController = navViewController.viewControllers.first as? HospitalTableViewController else{
                 fatalError("Unexpected Error \(segue.destination)")
            }
 
            print("Send")
                hospitalViewController.listaCentros.removeAll()
            print("Tamaño hospitalViewController : " + String(hospitalViewController.listaCentros.count))
            print("Tamaño del  listaCentros: " + String(self.listaCentros.count))
                hospitalViewController.listaCentros = self.listaCentros
            }
        }
        
    }
    


