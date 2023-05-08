//
//  PieChartViewModel.swift
//  Frugl
//
//  Created by Sebastian Guiscardo on 5/8/23.
//


import UIKit
import Firebase
import FirebaseFirestore

struct PieChartViewModel {
    
    // MARK: - Properties
    var slices: [Slice] = []
    
    mutating func fetchDataFromFirebase() {
        // Fetch data from Firebase here
        
        // Once you have the data, update the slices array
        // Calculate the percentages based on the fetched data
        // and create Slice objects
        
        // For example:
        let totalAmount = 500.0 // Assuming total amount fetched from Firebase is 500
        let sliceAmounts = [50.0, 100.0, 150.0, 100.0] // Sample slice amounts
        
        var newSlices: [Slice] = []
        
        for sliceAmount in sliceAmounts {
            let percent = sliceAmount / totalAmount
            let color = getRandomColor() // Function to generate random colors
            
            let slice = Slice(percent: percent, color: color)
            newSlices.append(slice)
        }
        
        slices = newSlices
    }
    
    // MARK: - Helper Functions
    private func getRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


