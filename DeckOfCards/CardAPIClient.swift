//
//  CardAPIClient.swift
//  DeckOfCards
//
//  Created by Benjamin Su on 11/7/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation
import UIKit

struct CardAPIClient {
    
    static let shared = CardAPIClient()
    
    private init() {}
    
    
    func newDeckShuffled(completion: @escaping ([String : Any]) -> () ) {
        let urlString = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
        let url = URL(string: urlString)
        
        guard let uUrl = url else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: uUrl) { (data, response, error) in
            if error == nil {
                guard let uData = data else { return }
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: uData, options: []) as! [String : Any]
                    
                    completion(json)
                    
                } catch {
                    
                }
            }
            }.resume()
    }
    
    func drawCards(deckID: String, cards: Int, completion: @escaping ([String : Any]) -> () ) {
        let urlString = "https://deckofcardsapi.com/api/deck/\(deckID)/draw/?count=\(cards)"
        let url = URL(string: urlString)
        
        guard let uUrl = url else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: uUrl) { (data, response, error) in
            if error == nil {
                guard let uData = data else { return }
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: uData, options: []) as! [String : Any]
                    
                    completion(json)
                    
                } catch {
                    
                }
            }
            }.resume()
    }
    
    func downloadImage(imageURL: URL, completion: @escaping (Bool, UIImage?) -> () ) {
    
        
        let session = URLSession.shared
        
        session.dataTask(with: imageURL) { (data, response, error) in
            if error == nil {
                guard let uData = data else { return }
                
                if let image = UIImage(data: uData) {
                    completion(true, image)

                } else {
                    completion(false, nil)
                }
                
            }
            }.resume()
    }
    
    
}






