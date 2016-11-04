//
//  CardAPIClient.swift
//  DeckOfCards
//
//  Created by Jim Campagno on 11/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation
import UIKit

typealias JSON = [String : Any]

struct CardAPIClient {
    
    static let shared = CardAPIClient()
    
    
    func shuffle(_ handler: @escaping (Bool, JSON?) -> Void) {
        
        let request = URLRequest(url: RequestType.shuffle.url)
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, response, error in
            
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! JSON
                else { handler(false, nil); return }
            
            handler(false, json)
            
            }.resume()
    }
    
    func drawCards(numberOfCards count: Int, withID id: String, _ handler: @escaping (Bool, [JSON]?) -> Void) {
        
        let request = URLRequest(url: RequestType.drawCards(id: id, count: count).url)
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, response, error in
            
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! JSON
                else { handler(false, nil); return }
            
            let cards = json["cards"] as! [[String : Any]]
                        
            handler(true, cards)
            
        }.resume()
    }
    
    func downloadImage(at url: URL, handler: @escaping (Bool, UIImage?) -> Void) {
        
        let request = URLRequest(url: url)
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, response, error in
            
            guard let imageData = data else { handler(false, nil); return }
            
            DispatchQueue.main.async {
                
                guard let image = UIImage(data: imageData) else { handler(false, nil); return }
                
                handler(true, image)
                
            }
        }.resume()
    }
    
}
