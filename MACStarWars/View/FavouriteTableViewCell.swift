//
//  StarShipTableViewCell.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/11/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import UIKit
import CoreData

class FavouriteTableViewCell: UITableViewCell {
    weak var delegate: CustomCellUpdater?
    var people : People!
    var index : Int!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
        self.backgroundColor = .white
        favButton.addTarget(self, action: #selector(butClick(_ : )), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imagePerson : UIImageView = {
        let set = UIImageView()
        set.clipsToBounds = true
        set.backgroundColor = .blue
        set.layer.cornerRadius = 10
        set.clipsToBounds = true
        set.contentMode = .scaleAspectFit
        set.backgroundColor = .black
        set.translatesAutoresizingMaskIntoConstraints = false
        return set
    }()
    
    var label : UILabel = {
        let set = UILabel()
        set.clipsToBounds = true
        set.font = UIFont.systemFont(ofSize: 16)
        set.translatesAutoresizingMaskIntoConstraints = false
        return set
    }()
    
    var favButton : UIButton = {
        let set = UIButton()
        set.setImage(#imageLiteral(resourceName: "FavFlip.png"), for: .normal)
        set.translatesAutoresizingMaskIntoConstraints = false
        set.imageView?.contentMode = .scaleAspectFit
        set.isUserInteractionEnabled = true
        return set
    }()

    func setUpCell()  {
        self.addSubview(imagePerson)
        self.addSubview(label)
        self.addSubview(favButton)
        NSLayoutConstraint.activate([imagePerson.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant : 8),
                                     imagePerson.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier : 1/3),
                                     imagePerson.topAnchor.constraint(equalTo: self.topAnchor , constant : 8),
                                     imagePerson.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant : -8)])
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: imagePerson.trailingAnchor , constant : 10),
                                     label.widthAnchor.constraint(equalToConstant: 150),
                                     label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     label.heightAnchor.constraint(equalToConstant: 60)])
        
        NSLayoutConstraint.activate([favButton.leadingAnchor.constraint(equalTo: label.trailingAnchor , constant : 8),
                                     favButton.widthAnchor.constraint(equalToConstant: 30),
                                     favButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     favButton.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    private var cellSess = URLSession(configuration: .default)
    func configureCell(){
        let url = Mics.getImageUrl(for: people.name)
        cellSess = URLSession(configuration: .default)
        NetworkService.getImage(from: url, session: cellSess) { (err, img) in
            if err == nil {
                DispatchQueue.main.async {
                    if let image = img {
                        self.imagePerson.image = image
                    }
                    
                }
            }
        }
        
    }
    func unLoadCell() {
        cellSess.invalidateAndCancel()
    }

}

extension FavouriteTableViewCell {
    
    @objc func butClick(_ sender : UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PeopleFav")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [PeopleFav]
           
            let todelete = result[index]
            context.delete(todelete)
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "username") as! String)
//            }
            
        } catch {
            
            print("Failed")
        }
        do {
            try context.save()
            self.delegate?.updateTableView(index: index)
        } catch {
            print("Failed saving")
        }
    }
}















