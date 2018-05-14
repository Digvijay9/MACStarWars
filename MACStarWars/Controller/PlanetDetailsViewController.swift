//
//  PlanetDetailsViewController.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/14/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import UIKit

class PlanetDetailsViewController: UIViewController {
    
    var url : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        planetImage.backgroundColor = .red
        planetImage.layer.cornerRadius = 8
        planetImage.image = #imageLiteral(resourceName: "planet.jpg")
        navigationItem.title = "Details"
 
        NetworkService.getPlanetDetails(from: url) { (err , planet) in
            if err == nil {
                guard let p = planet else {
                    return
                }
                DispatchQueue.main.async {
                    self.name.text = "Name : " + p.name
                    self.rotation_period.text = "Rotation Period : " + p.rotation_period
                    self.orbital_period.text = "Orbital_Period : " + p.orbital_period
                    self.diameter.text = "Diameter : " + p.diameter
                    self.climate.text = "Climate : " + p.climate
                    self.terrain.text = "Terrain : " + p.terrain
                    self.gravity.text = "Gravity : " + p.gravity
                    self.surface_water.text = "Surface Water : " + p.surface_water
                    self.population.text = "Population : " + p.population
                }
               
            }
        }
    }

    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rotation_period: UILabel!
    @IBOutlet weak var orbital_period: UILabel!
    @IBOutlet weak var diameter: UILabel!
    @IBOutlet weak var climate: UILabel!
    
    @IBOutlet weak var terrain: UILabel!
    @IBOutlet weak var gravity: UILabel!
    @IBOutlet weak var surface_water: UILabel!
    
    @IBOutlet weak var population: UILabel!
}
