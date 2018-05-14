//
//  Network.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/11/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import Foundation
import UIKit

enum ParsingError : Error{
    case badURl(String)
    case badResponse(String)
    case dataError(String)
    
}
enum Endpoint {
    case people
    case planet
    case species
    case starships
    case vehicles
    
    func URL() -> String {
        switch self {
        case .people: return "people/"
        case .planet: return "planets/"
        case .species: return "species/"
        case .starships: return "starships/"
        case .vehicles: return "vehicles/"
        }
    }
}
struct API {
    static let baseURL = "https://swapi.co/api/"
    
    
    static func fetchEndpoint(endpoint: Endpoint ) -> String {
        return  baseURL + endpoint.URL()
    }
}

class NetworkService {
    
    class func getPeople(from url : String , completion :@escaping (Error?,[People]?)->()){
        
        guard let urll = URL(string : url) else {
            completion(ParsingError.badURl("URL problem"),nil)
            return
        }

        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urll) { (data, resp, err) in
            if let error = err{
                completion(error, nil)
                return
            }
            //                        guard let httpsResp = (resp as? HTTPURLResponse)?.statusCode else {
            //                            completion(ParsingError.badResponse("Response problem"), nil)
            //                            return
            //                        }
            //
            //                        guard 200-205 ~= httpsResp else {
            //                            completion(ParsingError.badResponse("Status Code problem "), nil)
            //                            return
            //                        }
            //                        print("\(httpsResp)")
            
            guard let datas = data else{
                completion(ParsingError.dataError("data cant be found"),nil)
                return
            }
  
            do{
//                let jsonObj = try JSONSerialization.jsonObject(with:datas) as! [String :Any]
//                guard let gotJson = jsonObj["results"] as? [[String:String]] else { return }
//
//                let gotData:[People] = gotJson.flatMap{
//                    Pokemon(json: $0)
//                }
//
//                completion(nil , gotData)
//
                var people = [People]()
                let gotModel = try JSONDecoder().decode(Peoples.self, from: datas)
                people = gotModel.results.map{$0}
//                if let peopleNext = gotModel.next {
//                    completion(nil, people,peopleNext)
//                }
//                print(gotModel.next)
//                if let nextUrl = gotModel.next  {
//                    getPeople(from: nextUrl, completion: { (err, pep) in
//                        DispatchQueue.main.async {
//                            guard let peo = pep else {
//                                return
//                            }
//                            people += peo.map{$0}
//                        }
//
//                    })
//
//                }
                
                
            
                completion(nil, people)
            }catch{
                completion(ParsingError.dataError("Data parsing problem"),nil)
            }
            
            
        }
        task.resume()
        
    }
    
    class func getPeopleDetails(from url : String , completion :@escaping (Error?, PeopleDetails?)->()) {
        
            
            guard let urll = URL(string : url) else {
                
                return
            }
            
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urll) { (data, resp, err) in
                 if err != nil{
                    
                    return
                }
                //                        guard let httpsResp = (resp as? HTTPURLResponse)?.statusCode else {
                //                            completion(ParsingError.badResponse("Response problem"), nil)
                //                            return
                //                        }
                //
                //                        guard 200-205 ~= httpsResp else {
                //                            completion(ParsingError.badResponse("Status Code problem "), nil)
                //                            return
                //                        }
                //                        print("\(httpsResp)")
                
                guard let datas = data else{
                    
                    return
                }
                
                do{
                    
                    let gotModel = try JSONDecoder().decode(PeopleDetails.self, from: datas)
                    completion(nil, gotModel)
                    
                    
                    
                    
                    
                }catch let err {
                     completion(err, nil)
                    print("error in network")
                }
                
                
            }
            task.resume()
            
        
        
    }
    
    class func getImage(from url : String , session: URLSession  ,completion : @escaping (Error?,UIImage?) -> ()){
        
        if let imageC = ImageCache.shared.images.object(forKey: url as NSString){
            
            completion(nil,imageC)
            return
        }
        guard let uurl = URL(string: url)  else{
            completion(ParsingError.badURl("bad url"), nil)
            return
        }
//        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: uurl) { (data, resp, error) in
            if let error = error {
                completion(error, nil)
                return
            }
            
            //            guard let httpsResp = (resp as? HTTPURLResponse)?.statusCode else {
            //                return
            //            }
            //            guard 200...205 ~= httpsResp else{
            //                completion(ParsingError.badResponse("bad stats code"), nil)
            //                return
            //            }
            
            guard let d = data else {
                completion(ParsingError.dataError("data problem"), nil)
                return
            }
            
            guard let image = UIImage(data: d) else {
                completion(ParsingError.dataError("image data is not found"), nil)
                return
            }
            //            print("got image")
            ImageCache.shared.images.setObject(image, forKey: url as NSString)
            completion(nil, image)
            
            
        }
        task.resume()
        
    }
    
    class func getMovieDetails(from url : String , completion :@escaping (Error?, Movie?)->()) {
        
        
        guard let urll = URL(string : url) else {
            
            return
        }
        
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urll) { (data, resp, err) in
             if err != nil{
                
                return
            }
            //                        guard let httpsResp = (resp as? HTTPURLResponse)?.statusCode else {
            //                            completion(ParsingError.badResponse("Response problem"), nil)
            //                            return
            //                        }
            //
            //                        guard 200-205 ~= httpsResp else {
            //                            completion(ParsingError.badResponse("Status Code problem "), nil)
            //                            return
            //                        }
            //                        print("\(httpsResp)")
            
            guard let datas = data else{
                
                return
            }
            
            do{
                
                let gotModel = try JSONDecoder().decode(Movie.self, from: datas)
                completion(nil, gotModel)
                
                
                
                
                
            }catch let err {
                completion(err, nil)
                print("error in network")
            }
            
            
        }
        task.resume()
        
        
        
    }
    
    class func getPlanetDetails(from url : String , completion :@escaping (Error?, PlanetDetais?)->()) {

        guard let urll = URL(string : url) else {   return }
        
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urll) { (data, resp, err) in
             if err != nil{return }
            //                        guard let httpsResp = (resp as? HTTPURLResponse)?.statusCode else {
            //                            completion(ParsingError.badResponse("Response problem"), nil)
            //                            return
            //                        }
            //
            //                        guard 200-205 ~= httpsResp else {
            //                            completion(ParsingError.badResponse("Status Code problem "), nil)
            //                            return
            //                        }
            //                        print("\(httpsResp)")
            
            guard let datas = data else{return}
            
            do{
                
                let gotModel = try JSONDecoder().decode(PlanetDetais.self, from: datas)
                completion(nil, gotModel)
                
            }catch let err {
                completion(err, nil)
                print("error in network")
            }
        }
        task.resume()
        
    }
    
    class func getVehiclesDetails(from url : String , completion :@escaping (Error?, VehiclesDetails?)->()) {
        
        guard let urll = URL(string : url) else {   return }
        
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urll) { (data, resp, err) in
              if err != nil{return }
            //                        guard let httpsResp = (resp as? HTTPURLResponse)?.statusCode else {
            //                            completion(ParsingError.badResponse("Response problem"), nil)
            //                            return
            //                        }
            //
            //                        guard 200-205 ~= httpsResp else {
            //                            completion(ParsingError.badResponse("Status Code problem "), nil)
            //                            return
            //                        }
            //                        print("\(httpsResp)")
            
            guard let datas = data else{return}
            
            do{
                
                let gotModel = try JSONDecoder().decode(VehiclesDetails.self, from: datas)
                completion(nil, gotModel)
                
            }catch let err {
                completion(err, nil)
                print("error in network")
            }
        }
        task.resume()
        
    }
    class func gettStarShipDetails(from url : String , completion :@escaping (Error?, StarShipDetails?)->()) {
        
        guard let urll = URL(string : url) else {   return }
        
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urll) { (data, resp, err) in
              if err != nil{return }
            //                        guard let httpsResp = (resp as? HTTPURLResponse)?.statusCode else {
            //                            completion(ParsingError.badResponse("Response problem"), nil)
            //                            return
            //                        }
            //
            //                        guard 200-205 ~= httpsResp else {
            //                            completion(ParsingError.badResponse("Status Code problem "), nil)
            //                            return
            //                        }
            //                        print("\(httpsResp)")
            
            guard let datas = data else{return}
            
            do{
                
                let gotModel = try JSONDecoder().decode(StarShipDetails.self, from: datas)
                completion(nil, gotModel)
                
            }catch let err {
                completion(err, nil)
                print("error in network")
            }
        }
        task.resume()
        
    }
    
}
