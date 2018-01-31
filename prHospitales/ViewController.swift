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
    var listaCentros
    var location = Location()
    
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
        
        centrosFachada.buscarCentrosCercanos(tipo: 0)
        { (aListaCentros) in
            listaCentros = aListaCentros
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "nav", sender: sender)
            }
        }
        
        
        nuevaVentana(tipo: 0) {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "nav", sender: sender)
            }
        }
    }
    
    @IBAction func buttonAmbulatorio(_ sender: UIButton) {
        nuevaVentana(tipo: 1) {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "nav", sender: sender)
            }
        }
       
    }
    
    @IBAction func buttonUrgencias(_ sender: UIButton) {
        nuevaVentana(tipo: 2) {
             DispatchQueue.main.async {
            self.performSegue(withIdentifier: "nav", sender: sender)
            }
        }
    }
    
    func nuevaVentana(tipo: Int,completion: @escaping () -> Void){
        //location.configureLocations(){ () in
            print(tipo)
            let centrosFacade = CentrosFachada()
            centrosFacade.loadItemsAll(location:self.location)
            completion()
        //}
        
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
           // DispatchQueue.main.async { // Correct
            //    sleep(5)
                var centros = [Centro]()
                /*for item in self.listaCentros{
                    centros.append(item.centro)
                }*/
                hospitalViewController.listaCentros = self.listaCentros
                //hospitalViewController.centros = centros
                //hospitalViewController.prueba = "adios"
            }
        }
        
    }
    


