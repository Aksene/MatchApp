//
//  ViewController.swift
//  MatchApp
//
//  Created by Abdou on 6/16/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let model = CardModel()
    var cardsArray = [Card]()
    var firstCardFlippedIndex: IndexPath?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardsArray = model.getCards()
        
        //Set the view controller as the datasource and delegate of the collection view
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK:-  Collection View Delegate Methods
    // Retreives collection size
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //Return the number of cards
        return cardsArray.count
    }
    
    // Retrieves information for each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // Get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        //Return it
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //Configure the state of the cell based on the properties of the Card that it represents\
        
        let cardCell = cell as? CardCollectionViewCell
        //Get the card from the card array
        let card = cardsArray[indexPath.row]
        
        // Finish configuring cell
        cardCell?.configureCell(card: card)
        
     }
    
    
    // Handle card flip
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell was tapped: \(indexPath.row)")
        
        //Get a reference of the cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as?  CardCollectionViewCell
        
        //Check status of the card to determine how to flip it
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false{
            // Check the status of the card and determine how to flip
            if cell?.card?.isFlipped == false{
                cell?.flipUp()
                
                // Check if this was the first or second card to be flipped
                if (firstCardFlippedIndex == nil){
                    // This is the first flipped card
                    firstCardFlippedIndex = indexPath
                }else{
                    //Second card that is flipped
                    // Run the comparision logic
                    checkForMAtch(indexPath)
                }
            }
            
        }
        
        

        
    }
    
    // MARK: - Game Logic Methods
    
    func checkForMAtch(_ secondFlippedCardIndex:IndexPath){
        // Get the two card objects for the two indices and see if they match
        let cardOne = cardsArray[firstCardFlippedIndex!.row]
        var cardTwo = cardsArray[secondFlippedCardIndex.row]
        
        //Get 2 collection view cells that represents card one and two
        let cardOneCell = collectionView.cellForItem(at: firstCardFlippedIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        if cardOne.imageName == cardTwo.imageName{
            //Its a match
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            //Set the status and remove the cards
            cardOneCell?.remove()
            cardTwoCell?.remove()

        }
        else{
            //Its not a match
            cardOne.isFlipped = false
            cardOne.isFlipped = false
            
            //Flip them back over        }
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        firstCardFlippedIndex = nil
        
    }
}
