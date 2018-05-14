//
//  VehicleViewController.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/14/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//


    
    import UIKit
    import CoreData
    
    
    class VehicleViewController: UIViewController {
        
        
        var planet = [People]()
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.title = "StarWars"
            getPeople(from: API.fetchEndpoint(endpoint: .vehicles))
            setupTV()
            tableview.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        }
        
        var tableview : UITableView = {
            let set = UITableView()
            set.translatesAutoresizingMaskIntoConstraints = false
            return set
            
        }()
        
        
        func setupTV() {
            view.addSubview(tableview)
            NSLayoutConstraint.activate([tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                         tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                         tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                         tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        }
        
        func getPeople(from url : String){
            
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
                    
                    let gotModel = try JSONDecoder().decode(Peoples.self, from: datas)
                    DispatchQueue.main.async {
                        
                        gotModel.results.forEach{self.planet.append($0)}
                        self.tableview.dataSource = self
                        self.tableview.delegate = self
                        self.tableview.reloadData()
                        
                    }
                    if let peopleNext = gotModel.next {
                        self.getPeople(from: peopleNext)
                    }
                    
                    
                    
                    
                    
                }catch{
                    print("error in network")
                }
                
                
            }
            task.resume()
            
        }
        
        
        
    }
    
    typealias VDataSource = VehicleViewController
    extension VDataSource : UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //        print(people.count)
            return planet.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for : indexPath) as? TableViewCell else {
                fatalError("Cell not found")
            }
            cell.people = planet[indexPath.row]
            cell.label.text = planet[indexPath.row].name
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.imagePerson.image = #imageLiteral(resourceName: "vehicle.jpg")
            cell.id = "vehicle"
             cell.index = indexPath.row
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        
        
    }
    
    typealias VDelegate = VehicleViewController
    extension VDelegate :UITableViewDelegate{
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //        tableView.deselectRow(at: indexPath, animated: true)
            let vc = VehicleDetailsViewController()
            vc.url = planet[indexPath.row].url
     
  
            navigationController?.show(vc, sender: nil)
        }
        
//        func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//            guard let cell = cell as? TableViewCell else {
//                return
//            }
//            cell.unLoadCell()
//        }
}



