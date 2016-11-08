//
//  Card.swift
//  DeckOfCards
//
//  Created by Benjamin Su on 11/7/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation
import UIKit



class Card {
    
    let imageURLString: String
    let url: URL
    let code: String
    var image: UIImage?
    let value: String
    let suit: String
    let apiClient = CardAPIClient.shared
    var isDownloading = false
    
    init(data: [String : Any]) {
        
        self.imageURLString = data["image"] as? String ?? "n/a"
        self.url = URL(string: imageURLString)!
        self.code = data["code"] as! String
        self.value = data["value"] as! String
        self.suit = data["suit"] as! String
        
        
        
    }
    
    func downloadImage(handler: @escaping (Bool) -> () ) {
        self.isDownloading = true
        apiClient.downloadImage(imageURL: url) { (success, image) in
            if success {
                self.image = image
                self.isDownloading = false
                handler(true)
            } else {
                self.isDownloading = false
                handler(false)
            }
        }
        
    }
    
    
}


















