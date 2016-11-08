//
//  Deck.swift
//  DeckOfCards
//
//  Created by Benjamin Su on 11/7/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation

class Deck {
    
    let apiClient = CardAPIClient.shared
    
    var success: Bool!
    var shuffled: Bool!
    var deck_id: String!
    var remaining: Int!
    
    func update(data: [String : Any]) {
        
        self.success = data["success"] as! Bool
        self.shuffled = data["shuffled"] as! Bool
        self.deck_id = data["deck_id"] as! String
        self.remaining = data["remaining"] as! Int
    
    }
    
    func newDeck(completion: @escaping (Bool) -> () ) {
        
        apiClient.newDeckShuffled { (data) in
            self.update(data: data)
            completion(true)
        }
    }
    
    func drawCards(numberOfCards: Int, handler: @escaping (Bool, [Card]?) -> () ) {
        if numberOfCards <= remaining {
            apiClient.drawCards(deckID: deck_id, cards: numberOfCards, completion: { (data) in
                
                var cardStorage = [Card]()
                
                let cards = data["cards"] as! [[String : Any]]
                
                for card in cards {
                    
                    cardStorage.append(Card(data: card))
                    
                }
                
                handler(true, cardStorage)
                
            })
        } else {
            handler(false, nil)
        }
    }
    
}














