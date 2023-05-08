//
//  Budget.swift
//  Frugl
//
//  Created by Matthew Hill on 5/1/23.
//

import Foundation

class Budget {
    
    enum Key {
        static let amount = "amount"
        static let date = "date"
        static let uuid = "uuid"
        static let collectionType = "budget"
        static let name = "name"
    }
    
    var amount: Double
    var date: String
    var uuid: String
    var name: String
    
    var dictionaryRepresentation: [String: AnyHashable] {
        [Key.amount:self.amount,
         Key.date:self.date,
         Key.uuid:self.uuid,
         Key.name:self.name
        ]
    }
    
    init(amount: Double, date: String = Date().stringValue(), uuid: String = UUID().uuidString, name: String) {
        self.amount = amount
        self.date = date
        self.uuid = uuid
        self.name = name
    }
} // End of class

// MARK: - Extension

extension Budget {
    convenience init? (fromDictionary dictionary: [String: Any]) {
        guard let amount = dictionary[Key.amount] as? Double,
              let date = dictionary[Key.date] as? String,
              let uuid = dictionary[Key.uuid] as? String,
              let name = dictionary[Key.name] as? String else { return nil }
        
        self.init(amount: amount, date: date, uuid: uuid, name: name)
    }
}

extension Budget: Equatable {
    static func == (lhs: Budget, rhs: Budget) -> Bool {
        return lhs.uuid == rhs.uuid 
    }
}
