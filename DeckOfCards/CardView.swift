//
//  CardView.swift
//  DeckOfCards
//
//  Created by Jim Campagno on 11/4/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit



class CardView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var card: Card! {
        didSet {
            updateViewToReflectNewCard()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constrainEdges(to: self)
        backgroundColor = UIColor.clear
        setupGestureRecognizer()
    }
    
 
    
}


// MARK: - Card Methods
extension CardView {
    
    fileprivate func updateViewToReflectNewCard() {
        
        self.imageView.image = card.image
        
    }

}


// MARK: - Pan Gestures
extension CardView {
    
     func setupGestureRecognizer() {
        print("setup")
        let gesture = UIPanGestureRecognizer()
        gesture.addTarget(self, action: #selector(viewMoved))
        gesture.isEnabled = true
        self.addGestureRecognizer(gesture)
        
        
    }
    
     func viewMoved(_ gesture: UIPanGestureRecognizer) {
        
        print(1)
        
        let location = gesture.location(in: self.superview)
        print(2)
        self.center = location
        
        
        
    }
    
}




// MARK: - UIView Extension
extension UIView {
    
    func constrainEdges(to view: UIView) {
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}
