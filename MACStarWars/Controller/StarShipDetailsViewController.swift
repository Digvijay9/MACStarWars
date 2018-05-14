//
//  StarShipDetailsViewController.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/14/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import UIKit

class StarShipDetailsViewController: UIViewController {

    var url : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        starShipImage.backgroundColor = .red
        starShipImage.layer.cornerRadius = 8
        starShipImage.image = #imageLiteral(resourceName: "starship.jpeg")
        navigationItem.title = "Details"
        NetworkService.gettStarShipDetails(from: url) { (err, star) in
            
            if err == nil {
                guard let p = star else {
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
                    self.starship_class.text = "Starship Class : " + p.starship_class
                    self.hyperdrive_rating.text = "Hyperdrive Rating : " + p.hyperdrive_rating
                    self.MGLT.text = "MGLT : " + p.MGLT
                }
                
            }
        }
        
    }

    @IBOutlet weak var starShipImage: UIImageView!
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
    
    @IBOutlet weak var hyperdrive_rating: UILabel!
    @IBOutlet weak var MGLT: UILabel!
    
    @IBOutlet weak var starship_class: UILabel!
}
