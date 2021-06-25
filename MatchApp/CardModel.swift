//
//  CarModel.swift
//  MatchApp
//
//  Created by Abdou on 6/16/21.
//

import Foundation

class CardModel{
    func getCards() -> [Card] {
        
        //Declare array
        var generateCards = [Card]()
        
        //Randomly generat pairs of cards
        for a in 1...8{
            //Generate random number
            let randomNumber = Int.random(in: 1...13)
            
            
            //Creater two new card objects
            let card1 = Card()
            let card2 = Card()
            
            //Set their image names
            card1.imageName = "card\(randomNumber)"
            card2.imageName = "card\(randomNumber)"
            //Add them to the array
            generateCards += [card1, card2]
            print("Card #\(a) wit num: \(randomNumber)")
        }
        
        //Randomize the cards within the array
        generateCards.shuffle()
        
        print("Size: \(generateCards.count)")
        
        //Return array
        return generateCards
        
    }
}
