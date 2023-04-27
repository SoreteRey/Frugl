//
//  SignInViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import Foundation
import FirebaseAuth

protocol SignInAccountViewModelDelegate: AnyObject {
    func signInSuccessfull()
}

struct SignInAccountViewModel {
    
    // MARK: - Properties
    var delegate: SignInAccountViewModelDelegate?
    
    init(delegate: SignInAccountViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func signInAccount(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Error Signing In", error.localizedDescription)
                completion(false, error)
            }
            
            if let authResult {
                let user = authResult.user
                print(user.uid)
                completion(true, nil)
            }
        }
    }
}
