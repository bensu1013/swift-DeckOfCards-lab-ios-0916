//
//  Card.swift
//  DeckOfCards
//
//  Created by Jim Campagno on 11/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation
import UIKit



final class Card {
    
    private let imageURLString: String
    private let url: URL?
    private let code: String
    
    var image: UIImage?
    let value: String
    let suit: String
    let apiClient = CardAPIClient.shared
    var isDownloading = false

    
    init(with dictionary: [String : Any]) {
        imageURLString = dictionary["image"] as? String ?? "n/a"
        url = URL(string: imageURLString)
        code = dictionary["code"] as? String ?? "No code"
        value = dictionary["value"] as? String ?? "No value"
        suit = dictionary["suit"] as? String ?? "No suit"
    }
    
    func downloadImage(_ handler: @escaping (Bool) -> Void) {

        isDownloading = true
        
        guard let imageURL = url else { handler(false); return }
        
        apiClient.downloadImage(at: imageURL) { [unowned self] success, newImage in
         
            guard success else { handler(false); return }
            
            self.image = newImage
            
            self.isDownloading = false
            
            handler(true)
            
        }
    
    }
    
    
}


extension Card: CustomStringConvertible {
    
    var description: String {
        
        var result = ""
        
        result += "Value: " + value
        result += "\n Suit: " + suit
        result += "\nHas Image: " + (image != nil ? "YES" : "NO")
        result += "\n---\n"
        
        return result
        
    }
    
}
