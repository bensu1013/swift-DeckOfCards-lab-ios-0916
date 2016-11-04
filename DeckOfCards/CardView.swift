//
//  CardView.swift
//  DeckOfCards
//
//  Created by Jim Campagno on 11/4/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

protocol CardViewDelegate: class {
    func canUpdateImageView(_ cardView: CardView) -> Bool
}

class CardView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    weak var delegate: CardViewDelegate?
    
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
        setupGestureRecognizer()
        backgroundColor = UIColor.clear
    }
    
    private func updateViewToReflectNewCard() {
        guard !card.isDownloading else { return }
        
        if card.image == nil {
            card.downloadImage { [unowned self] success in
                guard self.delegate != nil else { return }
                if self.delegate!.canUpdateImageView(self) {
                    
                    UIView.transition(with: self.imageView, duration: 0.4, options: [.allowUserInteraction, .transitionCurlDown], animations: {
                        
                        self.imageView.image = self.card.image!

                    }) { success in
                        
                    }
                }
            }
            
        } else {
            imageView.image = card.image!
        }
    }
    
}


// MARK: - Pan Gestures
extension CardView {
    
     func setupGestureRecognizer() {
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(viewMoved))
        addGestureRecognizer(gesture)
        
    }
    
     func viewMoved(_ gesture: UIPanGestureRecognizer) {
        
        let center = gesture.location(in: superview)
        self.center = center
        
    }
    
    
}




extension UIView {
    
    func constrainEdges(to view: UIView) {
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}
