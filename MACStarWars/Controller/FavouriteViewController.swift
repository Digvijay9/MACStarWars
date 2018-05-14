//
//  StarShipsViewController.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/11/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import UIKit
import CoreData

class FavouriteViewController: UIViewController {

    var items : [PeopleFav] = [] {
        didSet{
            tableview.dataSource = self
            tableview.delegate = self
            tableview.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "StarWars"
        setupTV()
        tableview.register(FavouriteTableViewCell.self, forCellReuseIdentifier: "cell")
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFav()
    }
        
        
    }














    typealias SSTBDataSource = FavouriteViewController
    extension SSTBDataSource : UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for : indexPath) as? FavouriteTableViewCell else {
                fatalError("Cell not found")
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let person = items[indexPath.row]
            guard let name = person.value(forKeyPath: "name") as? String else {
                return UITableViewCell()
            }
            guard let url = person.value(forKeyPath: "url") as? String else {
                return UITableViewCell()
            }
            cell.label.text = name
            let id = person.value(forKey: "id") as? String
            if id == "people"{
                cell.people = People(name: name, url: url)
                cell.configureCell()
            } else if id == "planet" {
                cell.imagePerson.image = #imageLiteral(resourceName: "planet.jpg")
            } else if id == "vehicle" {
                cell.imagePerson.image = #imageLiteral(resourceName: "vehicle.jpg")
            } else if id == "starShip" {
                cell.imagePerson.image = #imageLiteral(resourceName: "starship.jpeg")
            }
            cell.index = indexPath.row
            cell.delegate = self
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
            return 150
        }
        
        
    }
    
    typealias SSTBDelegate = FavouriteViewController
    extension SSTBDelegate :UITableViewDelegate{
        func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            guard let cell = cell as? FavouriteTableViewCell else {
                return
            }
            cell.unLoadCell()
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let saveData = items[indexPath.row]
            guard let name = saveData.value(forKeyPath: "name") as? String else {
                return
            }
            guard let url = saveData.value(forKeyPath: "url") as? String else {
                return
            }
//            let obj = People(name: name, url: url)
            let id = saveData.value(forKey: "id") as? String
//            guard let cell = tableView.cellForRow(at: indexPath) as? FavouriteTableViewCell else {
//               return
//            }
            if id == "people"{
                let vc = PersonDetailViewController()
                vc.url = url
                vc.navTitle = name
                if let cell = tableView.cellForRow(at: indexPath) as? FavouriteTableViewCell{
                    vc.image = cell.imagePerson.image
                }
                
                navigationController?.show(vc, sender: nil)
            } else if id == "planet" {
                let vc = PlanetDetailsViewController()
                vc.url = url
                
//                if let cell = tableView.cellForRow(at: indexPath) as? FavouriteTableViewCell{
//                    vc.image = cell.imagePerson.image
//                }
               
                navigationController?.show(vc, sender: nil)
                
            } else if id == "vehicle" {
                let vc = VehicleDetailsViewController()
                vc.url = url
                
//                if let cell = tableView.cellForRow(at: indexPath) as? FavouriteTableViewCell{
//                    vc.image = cell.imagePerson.image
//                }
                
                navigationController?.show(vc, sender: nil)
                
            } else if id == "starShip" {
                let vc = StarShipDetailsViewController()
                vc.url = url
               
//                if let cell = tableView.cellForRow(at: indexPath) as? FavouriteTableViewCell{
//                    vc.image = cell.imagePerson.image
//                }
                
                navigationController?.show(vc, sender: nil)
               
            }
            
         
            
            
            
        }
        
}


extension FavouriteViewController{
    func fetchFav(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PeopleFav")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            items = try context.fetch(request) as! [PeopleFav]
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "username") as! String)
//            }
            
        } catch {
            
            print("Failed")
        }
    }
}
extension FavouriteViewController : CustomCellUpdater {

    
    func updateTableView(index: Int) {
        items.remove(at: index)
        self.tableview.reloadData()
    }
    
    
}
protocol CustomCellUpdater: class { // the name of the protocol you can put any
    func updateTableView(index : Int)
} 
