//
//  Constants.swift
//  Frugl
//
//  Created by Jake Gloschat on 5/9/23.
//

import Foundation

struct Constants {

    struct Global {
        static let usersFBCollection = "users"
    }

    struct Budget {
        static let amount = "amount"
        static let date = "date"
        static let uuid = "uuid"
        static let collectionType = "budget"
        static let name = "name"
    }

    struct Expenses {
        static let collectionName = "expenses"
        static let expenseType = "type"
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
}
