//
//  Budget.swift
//  Frugl
//
//  Created by Matthew Hill on 5/1/23.
//

import Foundation

class Budget {
	
    var amount: Double
    var date: String
    var uuid: String
    var name: String

    var dictionaryRepresentation: [String : AnyHashable] {
		[Constants.Budget.amount : self.amount,
		 Constants.Budget.date : self.date,
		 Constants.Budget.uuid : self.uuid,
		 Constants.Budget.name : self.name,
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
		guard let amount = dictionary[Constants.Budget.amount] as? Double,
			  let date = dictionary[Constants.Budget.date] as? String,
			  let uuid = dictionary[Constants.Budget.uuid] as? String,
			  let name = dictionary[Constants.Budget.name] as? String else {
			print("Failed to initialize Budget object")
			return nil
		}

		self.init(amount: amount, date: date, uuid: uuid, name: name)
	}
}

extension Budget: Equatable {
	static func == (lhs: Budget, rhs: Budget) -> Bool {
		return lhs.uuid == rhs.uuid
	}
}
