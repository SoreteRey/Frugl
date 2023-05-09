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
        
        pieChartTableView.dataSource = self
        
        viewModel.fetchDataFromFirebase { [weak self] in
            self?.pieChartView.slices = self?.viewModel.slices
            self?.pieChartTableView.reloadData()
            
        }
        
        func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            pieChartView.animateChart()
        }
    }
}
extension PieChartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.slices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pieChartCell", for: indexPath) as! PieChartTableViewCell
        let slice = viewModel.slices[indexPath.row]
        cell.configure(with: slice.percent)
        return cell
    }
}
//        pieChartView.slices = [
//            Slice(percent: 0.1, color: UIColor.systemGreen),
//            Slice(percent: 0.1, color: UIColor.systemOrange),
//            Slice(percent: 0.3, color: UIColor.systemGray),
//            Slice(percent: 0.2, color: UIColor.systemYellow),
//            Slice(percent: 0.1, color: UIColor.systemBlue),
//            Slice(percent: 0.1, color: UIColor.systemPurple),
//            //            Slice(percent: 0.1, color: UIColor.systemGreen),
//            //            Slice(percent: 0.1, color: UIColor.systemBlue),
//            //            Slice(percent: 0.1, color: UIColor.systemRed)
//
//        ]
