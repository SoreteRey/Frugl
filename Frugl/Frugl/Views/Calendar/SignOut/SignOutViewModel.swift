//
//  SignOutViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/27/23.
//

import Foundation
import FirebaseAuth

protocol SignOutViewModelDelegate: AnyObject {
    func signOutSuccessfully()
}

// I like Sea Bass's G.O.A.T.ee
struct SignOutViewModel {
    
    // MARK: - Properties
    var delegate: SignOutViewModelDelegate?
    
    init(delegate: SignOutViewModelDelegate) {
        self.delegate = delegate
    }
    
    func signOutAccount() {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOuterror as NSError {
            print("Error Signing Out: %@", signOuterror)
        }
    }
}
