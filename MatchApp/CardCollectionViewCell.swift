//
//  CardCollectionViewCell.swift
//  MatchApp
//
//  Created by Abdou on 6/16/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    var card:Card?
    
    func configureCell(card:Card){
        
        //Keep track of the card this cell reperesents
        self.card = card
        
        // Set the front image view to the image that represents the card
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        }
        else{
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        //Reset the state of the cell by checking the flipped status of the card and then shown the front or the back UIImageView accordingly
        if card.isFlipped == true{
            flipUp(speed: 0)
        }else{
            flipDown(speed: 0, delay: 0)
        }
        
    }
    
    func flipUp(speed:TimeInterval = 0.3){
        //Set the status of the card
        card?.isFlipped = true
        
        //Flip up Animation
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
    }
    
    func flipDown(speed:TimeInterval = 0.3, delay:TimeInterval = 0.5){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            //Flip down Animation
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromRight], completion: nil)
        }
        //Set the status of the card
        card?.isFlipped = false
        

    }
    
    func remove(){
        //Make Image invisible
        backImageView.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
    }
}

