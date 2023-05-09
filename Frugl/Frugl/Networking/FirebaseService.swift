//
//  FirebaseService.swift
//  Frugl
//
//  Created by Sebastian Guiscardo on 5/1/23.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}

protocol FireBaseSyncable {
    func saveExpense(expense: Expense)
    func loadExpenses(forBudget budget: Budget, completion: @escaping (Result<[Expense], FirebaseError>) -> Void)
    func deleteExpense(expense: Expense, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func saveBudget(budget: Budget)
    func loadBudget(completion: @escaping (Result<[Budget], FirebaseError>) -> Void)
    func deleteBudget(budget: Budget, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
}

struct FirebaseService: FireBaseSyncable {
    
    // MARK: - Properties
    let ref = Firestore.firestore()
    var budgetArray: [Budget] = []
    var budget: Budget?
    
    // MARK: - Functions
    
    func saveExpense(expense: Expense) {
            guard let userId = Auth.auth().currentUser?.uid else { return }
            guard let budget = CurrentUser.shared.currentBudget else { print("no current budget") ; return }

            ref.collection(Constants.Global.usersFBCollection).document(userId).collection(Constants.Budget.collectionType).document(budget.uuid).collection(Constants.Expenses.collectionName).document(expense.uuid).setData(expense.dictionaryRepresentation) { error in
                if let error = error {
                    print("Error saving expense: \(error.localizedDescription)")
                } else {
                    print("Expense saved successfully!")
                }
            }
        }
    
    func loadExpenses(forBudget budget: Budget, completion: @escaping (Result<[Expense], FirebaseError>) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        ref.collection(Constants.Global.usersFBCollection).document(userId).collection(Constants.Budget.collectionType).document(budget.uuid).collection(Constants.Expenses.collectionName).getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let docSnapShotArray = snapshot?.documents else {
                completion(.failure(.noDataFound))
                return
            }
            
            let dictionaryArray = docSnapShotArray.compactMap { $0.data()}
            let expense = dictionaryArray.compactMap { Expense(fromDictionary: $0) }
            completion(.success(expense))
        }
    }
    
    func saveBudget(budget: Budget) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        ref.collection(Constants.Global.usersFBCollection).document(userId).collection(Constants.Budget.collectionType).document(budget.uuid).setData(budget.dictionaryRepresentation)
        
        var budgets = budgetArray
        budgets.append(budget)
    }
    
    func loadBudget(completion: @escaping (Result<[Budget], FirebaseError>) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        ref.collection(Constants.Global.usersFBCollection).document(userId).collection(Constants.Budget.collectionType).getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let docSnapShot = snapshot?.documents else {
                completion(.failure(.noDataFound))
                return
            }
            
            let budgets = docSnapShot.compactMap { Budget(fromDictionary: $0.data()) }
            completion(.success(budgets))
        }
    }
    
    
    func deleteExpense(expense: Expense, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        ref.collection("users").document(userId).collection(Expense.Key.collectionType).document(expense.uuid).delete() { error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
            }
            completion(.success(true))
        }
    }
    
    func deleteBudget(budget: Budget, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        ref.collection(Constants.Global.usersFBCollection).document(userId).collection(Constants.Budget.collectionType).document(budget.uuid).delete() { error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
            }
            completion(.success(true))
        }
    }
}

