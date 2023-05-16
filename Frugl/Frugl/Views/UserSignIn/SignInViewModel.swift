//
//  SignInViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import Foundation
import FirebaseAuth
import UserNotifications

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
    
    func requestUserNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { permissonGranted, error in
            if let error = error {
                print("Error Requestion Authroization for User Notifications", error)
            }
            print("Permission \(permissonGranted ? "was" : "was NOT") granted for user notifications")
        }
    }
}
