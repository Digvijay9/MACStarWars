//
//  VehicleDetailsViewController.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/14/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import UIKit

class VehicleDetailsViewController: UIViewController {
    var url : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        vehicleImage.backgroundColor = .red
        vehicleImage.layer.cornerRadius = 8
        vehicleImage.image = #imageLiteral(resourceName: "vehicle.jpg")
        navigationItem.title = "Details"
        NetworkService.getVehiclesDetails(from: url) { (err, vehicle) in
        
            if err == nil {
                guard let p = vehicle else {
                    return
                }
                DispatchQueue.main.async {
                    self.name.text = "Name : " + p.name
                    self.model.text = "Model : " + p.model
                    self.manufacturer.text = "Manufacturer : " + p.manufacturer
                    self.cost_in_credits.text = "Cost in credits : " + p.cost_in_credits
                    self.length.text = "Length : " + p.length
                    self.max_atmosphering_speed.text = "Max Atmosphering Speed : " + p.max_atmosphering_speed
                    self.crew.text = "Crew : " + p.crew
                    self.cargo_capacity.text = "Cargo Capacity : " + p.cargo_capacity
                    self.consumables.text = "Consumables : " + p.consumables
                    self.vehicle_class.text = "Vehicle Class : " + p.vehicle_class
                }
                
            }
        }
        
    }


    

    
    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var manufacturer: UILabel!
    @IBOutlet weak var cost_in_credits: UILabel!
    @IBOutlet weak var length: UILabel!
    
    @IBOutlet weak var max_atmosphering_speed: UILabel!
    @IBOutlet weak var crew: UILabel!
    @IBOutlet weak var passengers: UILabel!
    
    @IBOutlet weak var cargo_capacity: UILabel!
    @IBOutlet weak var consumables: UILabel!
    
    @IBOutlet weak var vehicle_class: UILabel!

}
