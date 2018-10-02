//
//  secondViewController.swift
//  MovieMate
//
//  Created by Utsha on 12/6/17.
//  Copyright © 2017 Utsha. All rights reserved.
//

import UIKit

struct Tmovie: Decodable {
    
    
    let Id: String
    let ImdbId: String
    let OriginalTitle: String
    let Title: String
    let Description: String
    let TrailerLink: String
    let TrailerEmbedCode: String
    let Country: String
    let Region: String
    let Genre: String
    let RatingCount: Int
    let Rating: Double
    let TotalCriticReviews: Int
    let CensorRating: String
    let ReleaseDate: String
    let ReleaseDateAvailable: Int
    let ReleaseYear: Int
    let Runtime: Int
    let Budget: Int
    let Revenue: Int
    let PosterPath: String
    let PosterReleased: Int
    let LastUpdateTime: String
    
}

var mov = [Tmovie]()

class secondViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        let jsonUrlString = "http://api.cinemalytics.in/v2/analytics/TopMovies/?auth_token=7F84AB039CB1CB8C5ADFF3909CF08373"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            //let dataAsString = String(data: data, encoding: .utf8)
            
            //print(dataAsString.)
            
            do {
                
                    let movies = try
                    JSONDecoder().decode([Tmovie].self, from: data)
                    mov = movies
                    //print(mov[0].Title)
                    //print(mov.count)
                    DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            } catch let jsonErr {
                print("Error :",jsonErr)
            }
            
        }.resume()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mov.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Theatre") as? Theatre else { return UITableViewCell() }
        
        cell.titleLabel.text = "Title: " + mov[indexPath.row].Title
        cell.genreLabel.text = "Genre: " + mov[indexPath.row].Genre
        let Rating = String(mov[indexPath.row].Rating)
        cell.releaseLabel.text = "Rating: " + Rating
        
        if let imageURL = URL(string: mov[indexPath.row].PosterPath) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                    }
                }
            }
        }
        return cell
    }
    

}
