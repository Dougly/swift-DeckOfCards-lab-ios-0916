//
//  CardAPIClient.swift
//  DeckOfCards
//
//  Created by Douglas Galante on 11/15/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class CardAPIClient {
    
    static let shared = CardAPIClient()
    
    func getNewDeck(completion: @escaping ([String:Any]) -> Void) {
        
        let urlString = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
        let url = URL(string: urlString)
        if let url = url {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do{
                        let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                        completion(responseJSON)
                        
                    }catch{
                        print("failed to serialize JSON for new deck")
                    }
                }
            }
            task.resume()
        }
    }
    
    func getCardFrom(deck deckID: String, count: Int, completion: @escaping ([String:Any]) -> Void) {
        
        let urlString = "https://deckofcardsapi.com/api/deck/\(deckID)/draw/?count=\(count)"
        let url = URL(string: urlString)
        if let url = url {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do{
                        let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                        completion(responseJSON)
                    }catch{
                        
                    }
                }
               
            }
            task.resume()
        }
        
        
    }
    
    func downloadCardImage(from urlString: String, completion: @escaping (Bool, UIImage) -> Void) {
        let url = URL(string: urlString)
        if let url = url {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let downloadedImage = UIImage(data: data)
                    if let downloadedImage = downloadedImage {
                        completion(true, downloadedImage)
                    }
                }
            }
            task.resume()
        }
    }
    
}



















