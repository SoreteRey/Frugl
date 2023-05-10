//
//  CalendarViewModel.swift
//  Frugl
//
//  Created by Matthew Hill on 5/9/23.
//

import Foundation

protocol CalendarViewModelDelegate: AnyObject {
    func expensesLoadedSuccessfully()
}

class CalendarViewModel {
    // MARK: - Properties
    let service: FireBaseSyncable
    weak var delegate: CalendarViewModelDelegate?
    var expenses: [Expense] = []
    
    init(service: FireBaseSyncable = FirebaseService(), delegate: CalendarViewModelDelegate) {
        self.service = service
        self.delegate = delegate
        self.loadExpenses()
    }
    
    // MARK: - Functions
    func loadExpenses() {
        service.loadExpense { [weak self] result in
            switch result {
                
            case .success(let expenses):
                self?.expenses = expenses
                self?.delegate?.expensesLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
