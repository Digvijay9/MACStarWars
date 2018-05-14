//
//  TabBarcontroller.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/10/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import UIKit

class TabBarcontroller: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = ViewController()
        let peopleVC = UINavigationController(rootViewController: vc)
        peopleVC.tabBarItem.image = #imageLiteral(resourceName: "man-figure.png")
        peopleVC.tabBarItem.title = "People"
        
        let vc2 = FavouriteViewController()
        let favVC = UINavigationController(rootViewController: vc2)
        favVC.tabBarItem.image = #imageLiteral(resourceName: "love.png")
        favVC.tabBarItem.title = "Favourite"
        let vc3 = PlanetViewController()
        let planetVC = UINavigationController(rootViewController: vc3)
        planetVC.tabBarItem.image = #imageLiteral(resourceName: "earth-usa.png")
        planetVC.tabBarItem.title = "Planet"
        let vc4 = VehicleViewController()
        let vehicleVC = UINavigationController(rootViewController: vc4)
        vehicleVC.tabBarItem.image = #imageLiteral(resourceName: "caravan.png")
        vehicleVC.tabBarItem.title = "Vehicle"
        let vc5 = StarshipViewController()
        let starVC = UINavigationController(rootViewController: vc5)
        starVC.tabBarItem.image = #imageLiteral(resourceName: "airplane.png")
        starVC.tabBarItem.title = "Starship"
        viewControllers = [peopleVC,planetVC,vehicleVC,starVC,favVC]
        // Do any additional setup after loading the view.
    }

 
}
