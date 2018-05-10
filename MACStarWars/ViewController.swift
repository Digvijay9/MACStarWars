//
//  ViewController.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/9/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableview.dataSource = self
        tableview.delegate = self
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
    



}

typealias TBDataSource = ViewController
extension TBDataSource : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for : indexPath) as? TableViewCell else {
            fatalError("Cell not found")
        }
        cell.textLabel?.text = "hello"
        return cell
    }
    
    
}

typealias TBDelegate = ViewController
extension TBDelegate :UITableViewDelegate{
    
}
