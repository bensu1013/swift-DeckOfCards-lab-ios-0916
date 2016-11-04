//
//  RequestType.swift
//  DeckOfCards
//
//  Created by Jim Campagno on 11/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation


enum RequestType {
    
    static let baseURL = "https://deckofcardsapi.com/api/deck"
    
    case shuffle
    case drawCards(id: String, count: Int)
    
    var url: URL {
        
        switch self {
            
        case .shuffle:
            let string = RequestType.baseURL + "/new/shuffle/?deck_count=1"
            return URL(string: string)!
        case let .drawCards(id, count):
            let string = RequestType.baseURL + "/\(id)/draw/?count=\(count)"
            return URL(string: string)!
            
        }
        
        
    }
    
}
