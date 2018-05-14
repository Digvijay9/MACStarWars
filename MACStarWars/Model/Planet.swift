//
//  File.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/14/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import Foundation
struct Planets : Codable {
    var next : String?
    var results : [People]
}

struct Planet : Codable {
    var name : String
    var url : String
}


struct PlanetDetais : Codable {
    var name : String
    var rotation_period : String
    var orbital_period : String
    var diameter : String
    var climate : String
    var gravity : String
    var terrain : String
    var surface_water : String
    var population : String
   
}
