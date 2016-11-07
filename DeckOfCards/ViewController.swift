//
//  ViewController.swift
//  DeckOfCards
//
//  Created by Jim Campagno on 11/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let card = Card()
        
        let cardView = CardView()
        
        cardView.card = card
    
        // TODO: Call newDeck on your deck instance property here.
        
    }
    
    @IBAction func drawCard(_ sender: Any) {
        
        // TODO: Properly draw  a card from the deck.
        
    }
}
