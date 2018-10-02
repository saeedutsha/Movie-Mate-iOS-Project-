//
//  thirdViewController.swift
//  MovieMate
//
//  Created by Utsha on 12/7/17.
//  Copyright © 2017 Utsha. All rights reserved.
//

import UIKit


struct Cmovie: Decodable {
    
    let Title: String
    let Genre: String
    let ReleaseDate: String
    let PosterPath: String
    
}

var mov2 = [Cmovie]()

class thirdViewController: UIViewController, UITableViewDataSource {
    

    
    @IBOutlet weak var tableView2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView2.tableFooterView = UIView()
        
        let jsonUrlString = "http://api.cinemalytics.in/v2/movie/upcoming?auth_token=7F84AB039CB1CB8C5ADFF3909CF08373"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            //let dataAsString = String(data: data, encoding: .utf8)
            
            //print(dataAsString.)
            
            do {
                
                let movies = try
                    JSONDecoder().decode([Cmovie].self, from: data)
                mov2 = movies
                //print(mov[0].Title)
                //print(mov.count)
                DispatchQueue.main.async {
                    self.tableView2.reloadData()
                }
                
                
            } catch let jsonErr {
                print("Error :",jsonErr)
            }
            
            }.resume()
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mov2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView2.dequeueReusableCell(withIdentifier: "Soon") as? Soon else { return UITableViewCell() }
        
        cell.titleLabel2.text = "Title: " + mov2[indexPath.row].Title
        cell.genreLabel2.text = "Genre: " + mov2[indexPath.row].Genre
        cell.releaseLabel2.text = "Release Date: " + mov2[indexPath.row].ReleaseDate
        
        if let imageURL = URL(string: mov2[indexPath.row].PosterPath) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imgLabel2.image = image
                    }
                }
            }
        }
        return cell
    }

}
