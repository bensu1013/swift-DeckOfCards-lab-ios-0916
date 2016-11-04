//
//  Deck.swift
//  DeckOfCards
//
//  Created by Jim Campagno on 11/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation

protocol DeckDelegate: class {
    func newCardDealt(_ card: Card)
    func newDeckHasBeenMade(_ deck: Deck)
}


final class Deck {
    
    var success: Bool!
    var id: String!
    var shuffled: Bool!
    var remaining: Int!
    let apiClient = CardAPIClient.shared
    weak var delegate: DeckDelegate?
    var cards: [Card] = []
    
}


// MARK: - Create Deck
extension Deck {
    
     func newDeck(_ handler: @escaping (Bool) -> Void) {
        
        apiClient.newDeckShuffled() { [unowned self] success, json in
            
            DispatchQueue.main.async {
                
                guard let json = json else { handler(false); return }
                
                self.setupProperties(with: json)
                
                self.delegate?.newDeckHasBeenMade(self)
                
                handler(true)
                
            }
        }
    }
    
    
    func setupProperties(with json: JSON) {
        success = json["success"] as? Bool ?? false
        id = json["deck_id"] as? String ?? "no id"
        shuffled = json["shuffled"] as? Bool ?? false
        remaining = json["remaining"] as? Int ?? 0
    }
    
}



// MARK: - Draw Cards
extension Deck {
    
    func drawCards(numberOfCards count: Int, handler: @escaping (Bool, [Card]?) -> Void) {
        
        guard remaining >= count else { handler(false, nil); return }
        
        apiClient.drawCards(numberOfCards: count, withID: id) { [unowned self] success, cards in
            
            DispatchQueue.main.async {
                
                guard let rawCards = cards else { handler(false, nil); return }
                
                for json in rawCards {
                    
                    let newCard = Card(with: json)
                    self.cards.append(newCard)
                    self.delegate?.newCardDealt(newCard)

                }
                
                handler(true, self.cards)
                
            }
            
        }
        
    }
    
}


// MARK: - Custom String Convertible
extension Deck: CustomStringConvertible {
    
    var description: String {
        var result: String = "Success: " + (success! ? "True" : "False")
        result += "\nDeck ID: \(id)"
        result += "\nShuffled: " + (shuffled! ? "True" : "False")
        result += "\nRemaining: \(remaining!)"
        result += "\n\n"
        
        var cardsResult = ""
        
        for card in cards {
            
            cardsResult += "\n\(card)"
            
        }
        
        return result + cardsResult
    }
    
}
