//
//  Expense.swift
//  Frugl
//
//  Created by Matthew Hill on 5/1/23.
//

import Foundation

class Expense: Codable {
    
     enum Key {
        static let isSaving = "savings"
         static let isRecurring = "recurring"
         static let isIndividual = "individual"
         static let amount = "amount"
         static let name = "name"
         static let date = "date"
         static let dueDate = "dueDate"
         static let dueDateAlert = "dueDateAlert"
         static let dueDateSecondAlert = "dueDateSecondAlert"
         static let uuid = "uuid"
         static let collectionType = "expenses"
    }
    
    var isSavings: Bool
    var isRecurring: Bool
    var isIndividual: Bool
    var amount: Double
    var name: String
    var date: String
    var dueDate: String?
    var dueDateAlert: String?
    var dueDateSecondAlert: String?
    var uuid: String
    
    var dictionaryRepresentation: [String : AnyHashable] {
        [Key.isSaving:self.isSavings,
         Key.isRecurring:self.isRecurring,
         Key.isIndividual:self.isIndividual,
         Key.amount:self.amount,
         Key.name:self.name,
         Key.date:self.date,
         Key.dueDate:self.dueDate,
         Key.dueDateAlert:self.dueDateAlert,
         Key.dueDateSecondAlert:self.dueDateSecondAlert,
         Key.uuid:self.uuid
        ]
    }
    
    init(isSavings: Bool = false, isRecurring: Bool = false, isIndividual: Bool = false, amount: Double, name: String, date: String = Date().stringValue(), dueDate: String? = nil, dueDateAlert: String? = nil, dueDateSecondAlert: String? = nil, uuid: String = UUID().uuidString) {
        self.isSavings = isSavings
        self.isRecurring = isRecurring
        self.isIndividual = isIndividual
        self.amount = amount
        self.name = name
        self.date = date
        self.dueDate = dueDate
        self.dueDateAlert = dueDateAlert
        self.dueDateSecondAlert = dueDateSecondAlert
        self.uuid = uuid
    }
} // End of class

// MARK: - Extension
extension Expense {
    
    convenience init? (fromDictionary dictionary: [String : Any]) {
        guard let isSavings = dictionary[Key.isSaving] as? Bool,
              let isRecurring = dictionary[Key.isRecurring] as? Bool,
              let isIndividual = dictionary[Key.isIndividual] as? Bool,
              let amount = dictionary[Key.amount] as? Double,
              let name = dictionary[Key.name] as? String,
              let date = dictionary[Key.date] as? String,
              let dueDate = dictionary[Key.dueDate] as? String,
              let dueDateAlert = dictionary[Key.dueDateAlert] as? String,
              let dueDateSecondAlert = dictionary[Key.dueDateSecondAlert] as? String,
              let uuid = dictionary[Key.uuid] as? String else { return nil }
        
        self.init(isSavings: isSavings, isRecurring: isRecurring, isIndividual: isIndividual, amount: amount, name: name, date: date, dueDate: dueDate, dueDateAlert: dueDateAlert, dueDateSecondAlert: dueDateSecondAlert, uuid: uuid)
    }
}

extension Expense: Equatable {
    static func == (lhs: Expense, rhs: Expense) -> Bool {
        return lhs.uuid  == rhs.uuid
    }
}
