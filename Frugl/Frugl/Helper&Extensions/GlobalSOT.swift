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
    var user: User?
    var currentBudget: Budget?
    
    private init() {
        Auth.auth().addStateDidChangeListener { auth, firebaseUser in
            if let firebaseUser = firebaseUser {
//                self.user = User(firebaseUser: firebaseUser)
            } else {
                self.user = nil
            }
        }
    }
}
