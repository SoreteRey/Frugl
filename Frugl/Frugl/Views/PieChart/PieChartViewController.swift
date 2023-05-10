//
//  PieChartViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class PieChartViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var pieChartView: PieChartView!
    @IBOutlet weak var monthlyBudgetGoalTextField: UILabel!
    @IBOutlet weak var pieChartTableView: UITableView!
    
    // MARK: - Properties
     var viewModel = PieChartViewModel()
     
     // MARK: - Lifecycle
     override func viewDidLoad() {
         super.viewDidLoad()
         
         // Fetch data from Firebase and update the pie chart
         fetchDataAndUpdatePieChart()
     }
     
     func fetchDataAndUpdatePieChart() {
         viewModel.fetchDataFromFirebase { [weak self] in
             DispatchQueue.main.async {
                 self?.updatePieChart()
             }
         }
     }
     
     func updatePieChart() {
         let slices = viewModel.slices
         
         pieChartView.slices = slices.map { slice in
             return Slice(percent: slice.percent, color: slice.color)
         }
         
         pieChartView.setNeedsDisplay()
     }
 }
//extension PieChartViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.slices.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "pieChartCell", for: indexPath) as! PieChartTableViewCell
//        let slice = viewModel.slices[indexPath.row]
//        cell.configure(with: slice.percent)
//        return cell
//    }
//}

