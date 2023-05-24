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
    private let budgetKey = "currentBudgetID"
    // MAXPOFF: - remove didSet. Only for debug
    var currentBudget: Budget? 

    
    var currentBudgetID: String? {
        didSet {
            UserDefaults.standard.set(currentBudgetID, forKey: budgetKey)
        }
    }
    
    private init() {
        currentBudgetID = UserDefaults.standard.object(forKey: budgetKey) as? String
    }
}
