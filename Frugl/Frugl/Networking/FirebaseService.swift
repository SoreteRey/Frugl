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
    func saveExpense(expense: Expense, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func loadExpense(completion: @escaping (Result<[Expense], FirebaseError>) -> Void)
    func deleteExpense(expense: Expense, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func saveBudget(budget: Budget)
    func loadBudget(completion: @escaping (Result<Budget, FirebaseError>) -> Void)
}

struct FirebaseService: FireBaseSyncable {
    
    // MARK: - Properties
    let ref = Firestore.firestore()
    
    
    // MARK: - Functions
    
    func saveExpense(expense: Expense, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        ref.collection("users").document(userId).collection(Budget.Key.collectionType).document(expense.uuid).setData(expense.dictionaryRepresentation) { error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
            }
            completion(.success(true))
        }
    }
    
    func loadExpense(completion: @escaping (Result<[Expense], FirebaseError>) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        ref.collection("users").document(userId).collection(Budget.Key.collectionType).getDocuments { snapshot, error in
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
        
        ref.collection("users").document(userId).collection(Budget.Key.collectionType).document(budget.uuid).setData(budget.dictionaryRepresentation)
    }
    
    func loadBudget(completion: @escaping (Result<Budget, FirebaseError>) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        ref.collection("users").document(userId).collection(Budget.Key.collectionType).getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let docSnapShot = snapshot?.documents.first else {
                completion(.failure(.noDataFound))
                return
            }
            
            let budgetAmount = docSnapShot.data()
            guard let budget = Budget(fromDictionary: budgetAmount) else { return }
            completion(.success(budget))
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
}
