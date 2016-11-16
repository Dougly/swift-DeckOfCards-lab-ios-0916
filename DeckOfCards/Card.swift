//
//  Card.swift
//  DeckOfCards
//
//  Created by Douglas Galante on 11/15/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit


class Card {
    
    let apiClient = CardAPIClient.shared
    
    var imgURLString: String!
    var code: String!
    var image: UIImage?
    var value: String!
    var suit: String!
    var isDownloading = false
    
    
    init(dict: [String:Any]) {
        self.imgURLString = dict["image"] as! String
        self.code = dict["code"] as! String
        self.value = dict["value"] as! String
        self.suit = dict["suit"] as! String

    }
    
    func downloadImage(handler: @escaping (Bool) -> Void) {
        apiClient.downloadCardImage(from: self.imgURLString) { (success, image) in
            DispatchQueue.main.async {
                self.image = image
                handler(true)
            }
            
        }
    }
}
