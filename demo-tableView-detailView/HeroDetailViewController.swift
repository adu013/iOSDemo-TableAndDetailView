//
//  HeroDetailViewController.swift
//  demo-tableView-detailView
//
//  Created by Ari D on 12/08/20.
//  Copyright © 2020 Ari D. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var legsLabel: UILabel!
    
    var hero: HeroStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "Name: " + hero!.localized_name
        attributeLabel.text = "Attribute: " + hero!.primary_attr
        attackLabel.text = "Attack Type" + hero!.attack_type
        legsLabel.text = "Legs: \((hero?.legs)!)"
     
        let urlString = "https://api.opendota.com" + hero!.img
        let url = URL(string: urlString)
        imageView.downloadedFrom(url: url!)
    }
    
}
