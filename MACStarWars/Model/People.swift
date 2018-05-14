//
//  People.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/11/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import Foundation

struct Peoples : Codable {
    var next : String?
    var results : [People]
}

struct People : Codable {
    var name : String
    var url : String
}
enum Films : String , Codable{
    case movie1 = "https://swapi.co/api/films/1/"
    case movie2 = "https://swapi.co/api/films/2/"
    case movie3 = "https://swapi.co/api/films/3/"
    case movie4 =  "https://swapi.co/api/films/4/"
}

struct PeopleDetails:Codable {
    var name : String
    var height : String
    var mass : String
    var hair_color: String
    var skin_color:String
    var eye_color:String
    var birth_year:String
    var gender:String
 
    var films : [String]?
    
    
}

class Mics {
    class func getImageUrl(for name:String)->String {
        let nameWithoutChar = name.folding(options: .diacriticInsensitive, locale: .current)
        let chars : Set<Character> = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_")
        let readyName = String(nameWithoutChar.filter {chars.contains($0) })
       return "https://raw.githubusercontent.com/sbassett1/swImages/master/"+readyName+".png"
}
}



extension String {
    var numbers: String {
        
        return self.filter{"0"..."9" ~= $0}
    }
}
