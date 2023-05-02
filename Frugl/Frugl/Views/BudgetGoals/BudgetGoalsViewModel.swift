//
//  BudgetGoalsViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/27/23.
//

import Foundation
import FirebaseFirestore

protocol BudgetGoalsViewModelDelegate: AnyObject {
    
}

struct BudgetGoalsViewModel {
    // MARK: - Properties
    var budget: Budget?
    let service: FireBaseSyncable
    private weak var delegate: BudgetGoalsViewModelDelegate?
    init(serviceInjected: FireBaseSyncable = FirebaseService(), delegate: BudgetGoalsViewModelDelegate) {
        self.service = serviceInjected
        self.delegate = delegate
    }
    // MARK: - Functions
   
           
            
}
