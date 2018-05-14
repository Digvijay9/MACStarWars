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
