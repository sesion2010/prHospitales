//
//  HospitalTableViewController.swift
//  prHospitales
//
//  Created by INFTEL 03 on 30/1/18.
//  Copyright © 2018 INFTEL 06. All rights reserved.
//

import UIKit
import MapKit
class HospitalTableViewController: UITableViewController {

    var listaCentros = [CentroDistancia]()
    var prueba: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(listaCentros.description)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaCentros.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "celdaHospital"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HospitalTableViewCell  else {
            fatalError("The dequeued cell is not an instance of HospitalTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let centro = listaCentros[indexPath.row]
        let nombre = String(centro.distancia).split(separator: ".")[0]
        cell.initcell(name: centro.centro.nombre,address: String(centro.centro.direccion + " a " + nombre + " m"),valoracion: String(centro.centro.val))
        return cell
    }
    
    @IBAction func buttonCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let latitude: CLLocationDegrees = CLLocationDegrees(listaCentros[indexPath.row].centro.lat)
        let longitude: CLLocationDegrees = CLLocationDegrees(listaCentros[indexPath.row].centro.long)
        
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = listaCentros[indexPath.row].centro.nombre
        mapItem.openInMaps(launchOptions: options)
    }
    
    

}
