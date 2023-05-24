//
//  DateExtension.swift
//  Frugl
//
//  Created by Matthew Hill on 5/1/23.
//

import Foundation

extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
