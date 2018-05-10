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
        peopleVC.tabBarItem.title = "people"
        viewControllers = [peopleVC]
        // Do any additional setup after loading the view.
    }

 
}
