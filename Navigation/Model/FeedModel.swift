//
//  FeedModel.swift
//  Navigation
//
//  Created by Aleksey on 19.11.2022.
//

import Foundation

struct FeedModel {
    
    let secretWord: String = "developer"
    
    func check(word: String) -> Bool {
        secretWord == word
    }
}
