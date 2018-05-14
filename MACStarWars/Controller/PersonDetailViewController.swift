//
//  PersonDetailViewController.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/11/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    var url : String!
    var navTitle : String!
    var image : UIImage!
    var films : [String]?{
        didSet{
            for i in films!{

                if let ints = Int(i.numbers) {
                    if ints < 7 {
                        NetworkService.getMovieDetails(from: i, completion: { (err, movie) in
                            if err == nil {
                                DispatchQueue.main.async {
                                    if let m = movie {
                                        
                                        self.filmNames = m
//                                        self.filmNames?.append(m)
                                    }
                                }
                              
                            }
                        })
                    }
                }
         
            }
        }
    }
    var filmNames : Movie?{
        didSet{
            movieButtons[0].setTitle(filmNames?.title, for: .normal)
       
//            setButtonTitle()
            
        }
    }

 
    
//    func setButtonTitle(){
//        guard let film = filmNames else {
//            print("film titiles not extracted")
//            return
//
//        }
//        for i in 0..<6{
//            let button = movieButtons[i]
//            if  film.indices.contains(i){
//                let m = film[i]
//                button.setTitle(m.title, for: .normal)
//            }else{
//                button.setTitle("NA", for: .normal)
//            }
//
//
//        }

//    }
    
    
    
    @IBOutlet weak var personImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        personImage.backgroundColor = .red
        personImage.layer.cornerRadius = 8
        personImage.image = image
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = navTitle
        NetworkService.getPeopleDetails(from: url) { (err, data) in
            if err == nil {
                guard let details = data else {
                    print("nothing found")
                    return
                }
                DispatchQueue.main.async {
                    self.homeworld.text = "Name : " + details.name
                    self.gender.text = "Gender : " + details.gender
                    self.height.text = "Height : " + details.height
                    self.mass.text = "Mass : " + details.mass
                    self.birth_year.text = "Birth Year : " + details.birth_year
                    self.eye_color.text = "Eye Color : " + details.eye_color
                    self.skin_color.text = "Skin Color" + details.skin_color
                    self.hair_color.text = "Hair Color" + details.hair_color
                    if let movies = details.films{
                        self.films = movies.map{$0}
                    }
//                    print(details.films)
//                    self.navigationItem.title = details.name
                }

               
                
            }
        }
     
    }

    
    @IBOutlet weak var homeworld: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var birth_year: UILabel!
    
    @IBOutlet weak var eye_color: UILabel!
    
    @IBOutlet weak var skin_color: UILabel!
    
    @IBOutlet weak var hair_color: UILabel!
    @IBOutlet weak var mass: UILabel!
    
    
    @IBOutlet weak var height: UILabel!
    
    @IBOutlet var movieButtons: [UIButton]!
    
    
}


//
//
//typealias PDTBDataSource = PersonDetailViewController
//extension PDTBDataSource : UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //        print(people.count)
//        return 4
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for : indexPath) as? TableViewCell else {
//            fatalError("Cell not found")
//        }
//        cell.label.text = "Hello"
//
//        return cell
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
//
//
//}
//
//typealias PDTBDelegate = PersonDetailViewController
//extension PDTBDelegate :UITableViewDelegate{
//    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    //        let vc = PersonDetailViewController()
//    //        navigationController?.show(vc, sender: nil)
//    //    }
//
//}

















