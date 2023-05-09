//
//  PieChartViewModel.swift
//  Frugl
//
//  Created by Sebastian Guiscardo on 5/8/23.
//

import UIKit
import Firebase
import FirebaseFirestore

struct PieSlice {
    var percent: CGFloat
    var color: UIColor
}

class PieChartViewModel {
    var slices: [Slice] = []
    
    func fetchDataFromFirebase() {
        // Configure Firebase if it's not already configured
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        // Reference to your Firebase Firestore database
        let db = Firestore.firestore()
        
        // Assume you have a "amounts" collection in your Firebase Firestore
        let amountsCollection = db.collection("amount")
        
        amountsCollection.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            // Extract the amounts from the documents
            let sliceAmounts = documents.compactMap { $0.data()["amount"] as? Double }
            
            
            // Calculate the total amount
            let totalAmount = sliceAmounts.reduce(0, +)
            print(totalAmount)
            
            // Update the slices array
            self.slices = sliceAmounts.map { amount in
                let percent = CGFloat(amount / totalAmount)
                let color = self.getRandomColor()
                return Slice(percent: percent, color: color)
            }
        }
    }
    
    // Helper function to generate random colors
    private func getRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

