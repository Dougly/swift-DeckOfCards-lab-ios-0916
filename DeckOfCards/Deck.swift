//
//  Deck.swift
//  DeckOfCards
//
//  Created by Douglas Galante on 11/15/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation

class Deck {
    
    let apiClient = CardAPIClient.shared
    
    var success: Bool!
    var deckID: String!
    var shuffled: Bool!
    var remaining: Int!
    var cards: [Card] = []
    
    func newDeck(_ completion: @escaping (Bool) -> Void) {
        apiClient.getNewDeck { (response) in
            self.success = response["success"] as! Bool
            self.deckID = response["deck_id"] as! String
            self.shuffled = response["shuffled"] as! Bool
            self.remaining = response["remaining"] as! Int
            completion(true)
        }
        
    }
    
    func drawCards(numberOfCards count: Int, completion: @escaping (Bool, [Card]?) -> Void) {
        
        apiClient.getCardFrom(deck: self.deckID, count: count) { dictionary in
            
            DispatchQueue.main.async {
                
                
                
                let arrayOfCards = dictionary["cards"] as! [[String:Any]]
                self.remaining = dictionary["remaining"] as! Int
                
                for card in arrayOfCards {
                    let newCard = Card(dict: card)
                    self.cards.append(newCard)
                }
                
                completion(true, self.cards)
            }
        }
    }
    
}
