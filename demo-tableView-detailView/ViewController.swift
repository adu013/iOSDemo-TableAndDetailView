//
//  ViewController.swift
//  demo-tableView-detailView
//
//  Created by Ari D on 12/08/20.
//  Copyright © 2020 Ari D. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Initial an empty array of type HeroStats
    var heroes = [HeroStats]()
    
    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    // function viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // function for number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    
    // function for cell for rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = heroes[indexPath.row].localized_name.capitalized
        return cell
    }

    
    // function (override) for perform Segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showHeroDetails", sender: self)
    }
    
    
    // function (override) for prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroDetailViewController {
            destination.hero = heroes[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    // function to call api (api.opendota.com)
    func downloadJSON(completed: @escaping () -> ())  {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        URLSession.shared.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                do {
                    
                    self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("Error !!!")
                }
            } else {
                print("there is error")
            }
        }.resume()
    }
}

