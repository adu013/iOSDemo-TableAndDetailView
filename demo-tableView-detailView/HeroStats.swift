//
//  HeroStats.swift
//  demo-tableView-detailView
//
//  Created by Ari D on 12/08/20.
//  Copyright © 2020 Ari D. All rights reserved.
//

import Foundation
import UIKit

struct HeroStats: Decodable {
    
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
}

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
            
        }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
