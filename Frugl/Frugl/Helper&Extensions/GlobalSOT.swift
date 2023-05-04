//
//  GlobalSOT.swift
//  Frugl
//
//  Created by Jake Gloschat on 5/4/23.
//

import Foundation
import FirebaseAuth

class CurrentUser {
    static let shared = CurrentUser()
    var currentBudget: Budget?
    
}
