//
//  User.swift
//  Frugl
//
//  Created by Jake Gloschat on 5/4/23.
//

import Foundation

class User {
    
    enum Key {
        static let email = "email"
        static let password = "password"
        static let uuid = "uuid"
        static let firebaseUser = "firebaseUser"
    }
    
    var email: String
    var password: String
    var uuid: String
    var firebaseUser: String
    
    var dictionaryRepresentation: [String: AnyHashable] {
        [
            Key.email:self.email,
            Key.password:self.password,
            Key.uuid:self.uuid,
            Key.firebaseUser:self.firebaseUser
        ]
    }
    
    init(email: String, password: String, uuid: String, firebaseUser: String) {
        self.email = email
        self.password = password
        self.uuid = uuid
        self.firebaseUser = firebaseUser
    }
    
} // End of class

extension User {
    convenience init? (fromDictionary dictionary: [String: Any]) {
        guard let firebaseUser = dictionary[Key.firebaseUser] as? String,
              let email = dictionary[Key.email] as? String,
              let password = dictionary[Key.password] as? String,
              let uuid = dictionary[Key.uuid] as? String else { return nil }
        
        self.init(email: email, password: password, uuid: uuid, firebaseUser: firebaseUser)
    }
}
