//
//  Expense.swift
//  Frugl
//
//  Created by Matthew Hill on 5/1/23.
//

import Foundation

class Expense: Codable {

	enum ExpenseType: String, Codable {
		case savings = "savings"
		case recurring = "recurring"
		case individual = "individual"
	}

	var type: ExpenseType
	var amount: Double
	var name: String
	var date: String
	var dueDate: String?
	var dueDateAlert: String?
	var dueDateSecondAlert: String?
	var uuid: String

	var dictionaryRepresentation: [String: AnyHashable] {
		[
			Constants.Expenses.expenseType : self.type.rawValue,
			Constants.Expenses.amount : self.amount,
			Constants.Expenses.name : self.name,
			Constants.Expenses.date : self.date,
			Constants.Expenses.dueDate : self.dueDate,
			Constants.Expenses.dueDateAlert : self.dueDateAlert,
			Constants.Expenses.dueDateSecondAlert : self.dueDateSecondAlert,
			Constants.Expenses.uuid : self.uuid
		]
	}

	init(type: ExpenseType, amount: Double, name: String, date: String = Date().stringValue(), dueDate: String? = nil, dueDateAlert: String? = nil, dueDateSecondAlert: String? = nil, uuid: String = UUID().uuidString) {
		self.type = type
		self.amount = amount
		self.name = name
		self.date = date
		self.dueDate = dueDate
		self.dueDateAlert = dueDateAlert
		self.dueDateSecondAlert = dueDateSecondAlert
		self.uuid = uuid
	}
} // End of class

// MARK: - Extensions
extension Expense {
	convenience init? (fromDictionary dictionary: [String: Any]) {
		guard let typeString = dictionary[Constants.Expenses.expenseType] as? String,
			  let amount = dictionary[Constants.Expenses.amount] as? Double,
			  let name = dictionary[Constants.Expenses.name] as? String,
			  let date = dictionary[Constants.Expenses.date] as? String,
			  let uuid = dictionary[Constants.Expenses.uuid] as? String else { return nil }

		guard let type = ExpenseType(rawValue: typeString) else { return nil }

		let dueDate = dictionary[Constants.Expenses.dueDate] as? String
		let dueDateAlert = dictionary[Constants.Expenses.dueDateAlert] as? String
		let dueDateSecondAlert = dictionary[Constants.Expenses.dueDateSecondAlert] as? String

		self.init(type: type, amount: amount, name: name, date: date, dueDate: dueDate, dueDateAlert: dueDateAlert, dueDateSecondAlert: dueDateSecondAlert, uuid: uuid)
	}
}


extension Expense: Equatable {
	static func == (lhs: Expense, rhs: Expense) -> Bool {
		return lhs.uuid  == rhs.uuid
	}
}
