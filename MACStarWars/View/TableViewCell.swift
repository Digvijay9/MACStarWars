//
//  TableViewCell.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/10/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import UIKit
import CoreData

class TableViewCell: UITableViewCell {
    var people : People!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setUpCell()
        
        favButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
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
//        set.backgroundColor = .red
        set.translatesAutoresizingMaskIntoConstraints = false
        return set
    }()
    
    var favButton : UIButton = {
        let set = UIButton()
//        set.backgroundColor = .brown
        set.setImage(#imageLiteral(resourceName: "Fav.jpg"), for: .normal)
//        set.setTitle("FAV", for: .normal)
//        set.clipsToBounds = true
        set.translatesAutoresizingMaskIntoConstraints = false
        set.imageView?.contentMode = .scaleAspectFit
        set.isUserInteractionEnabled = true
       
    
//        set.tintColor = .red
        return set
    }()
    var isFav = false
    @objc func buttonClicked(_ sender: UIButton){
        if isFav == false{
            isFav = true
            saveFav()
            favButton.setImage(#imageLiteral(resourceName: "FavFlip.png"), for: .normal)
            
        }else{
            isFav = false
            favButton.setImage(#imageLiteral(resourceName: "Fav.jpg"), for: .normal)
        }
        
        
    }
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












extension TableViewCell{
    func saveFav(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PeopleFav", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        print(people.name)
                newUser.setValue(people.url, forKey: "url")
                newUser.setValue(people.name, forKey: "name")
                newUser.setValue(true, forKey: "isFav")
                newUser.setValue("true", forKey: "image")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        
    }

}
