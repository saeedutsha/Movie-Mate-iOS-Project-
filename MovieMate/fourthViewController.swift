//
//  fourthViewController.swift
//  MovieMate
//
//  Created by Utsha on 12/9/17.
//  Copyright © 2017 Utsha. All rights reserved.
//

import UIKit
import FirebaseDatabase

class fourthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! watch
        let movie: Watchlist
        movie = movieList[indexPath.row]
        //print(movie)
        cell.lab1.text = "Title: " + movie.title!
        cell.lab2.text = "Rating: " + movie.rating!
        return cell
        
    }
    
    
    
    @IBOutlet weak var txt1: UITextField!
    
    @IBOutlet weak var txt2: UITextField!
    
    @IBOutlet weak var table: UITableView!
    
    var movieList = [Watchlist]()
    
    var ref:DatabaseReference?
    
    @IBAction func addBtn(_ sender: UIButton)
    {
        if (txt1.text != "" && txt2.text != "")
        {
        add()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let movie = movieList[indexPath.row]
        let alertControleer = UIAlertController(title: movie.title, message: "Do you want to Delete? ", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .cancel) { (_) in
            self.deleteMovie(id: movie.id!)
        }
        
        
        alertControleer.addAction(deleteAction)
        present(alertControleer, animated: true, completion: nil)
    }
    
  
    
    func deleteMovie(id: String)
    {
        ref?.child(id).setValue(nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("lists")
    
        ref?.observe(DataEventType.value, with: { (snapshot) in

            if snapshot.childrenCount > 0 {
                
                self.movieList.removeAll()
                for movies in snapshot.children.allObjects as![DataSnapshot] {
                    
                    let movieObject = movies.value as? [String: AnyObject]
                    let movieId  = movieObject?["id"]
                    let movieTitle  = movieObject?["title"]
                    let movieRating = movieObject?["rating"]
                    
                    
                    let movie = Watchlist(id: movieId as! String?, title: movieTitle as! String?, rating: movieRating as! String?)
                    
                    self.movieList.append(movie)
                }
                
                
                self.table.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    
    func add()
    {
        let key = ref?.childByAutoId().key
        let movie = ["id":key,
                     "title": txt1.text! as String,
                     "rating": txt2.text! as String
                     ]
        ref?.child(key!).setValue(movie)
        txt1.text = ""
        txt2.text = ""
        
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
