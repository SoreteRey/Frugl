//
//  CreateExpenseViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 5/2/23.
//

import Foundation
import UserNotifications

protocol CreateExpenseViewModelDelegate: AnyObject {
    func expenseCreatedSuccessfully()
}

class CreateExpenseViewModel {
    
    // MARK: - Properties
    private weak var delegate: CreateExpenseViewModelDelegate?
    private var service: FireBaseSyncable
    var expense: Expense?
    
    init(delegate: CreateExpenseViewModelDelegate, service: FireBaseSyncable = FirebaseService()) {
        self.delegate = delegate
        self.service = service
    }
    
    func createExpense(expense: Expense) {
        service.saveExpense(expense: expense)
        self.delegate?.expenseCreatedSuccessfully()
    }
    
    func scheduleNotification(with expense: Expense) {
        
        if expense.dueDateAlert == "" {
            return
            
        } else {
            
            let center = UNUserNotificationCenter.current()
            let content = UNMutableNotificationContent()
            content.title = "Payment Coming Up!"
            content.body = "\(expense.name) due on \(expense.dueDate ?? "")"
            content.categoryIdentifier = "alert"
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.day = Int(expense.dueDateAlert ?? "")
            dateComponents.hour = 12
            dateComponents.minute = 00
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
    }
    
    func scheduleNotificationTwo(with expense: Expense) {
        
        if expense.dueDateSecondAlert == "" {
            return
            
        } else {
            
            let center = UNUserNotificationCenter.current()
            let content = UNMutableNotificationContent()
            content.title = "Payment Coming Up!"
            content.body = "\(expense.name) due on \(expense.dueDate ?? "")"
            content.categoryIdentifier = "alert"
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.day = Int(expense.dueDateSecondAlert ?? "")
            dateComponents.hour = 12
            dateComponents.minute = 00
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
    }
    
    func scheduleNotificationDue(with expense: Expense) {
        
        if expense.dueDate == "" {
            return
            
        } else {
            
            let center = UNUserNotificationCenter.current()
            let content = UNMutableNotificationContent()
            content.title = "Payment Coming Up!"
            content.body = "\(expense.name) due Today."
            content.categoryIdentifier = "alert"
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.day = Int(expense.dueDate ?? "")
            dateComponents.hour = 12
            dateComponents.minute = 54
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
    }
}
