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
        tableview.register(StarShipTableViewCell.self, forCellReuseIdentifier: "cell")
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for : indexPath) as? StarShipTableViewCell else {
                fatalError("Cell not found")
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let person = items[indexPath.row]
            cell.label.text = person.value(forKeyPath: "name") as? String
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
