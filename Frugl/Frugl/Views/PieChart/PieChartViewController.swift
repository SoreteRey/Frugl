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
    
    // MARK: - Properties
    var viewModel = PieChartViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchDataFromFirebase()
               pieChartView.slices = viewModel.slices
        
//        pieChartView.slices = [
//            Slice(percent: 0.1, color: UIColor.systemRed),
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pieChartView.animateChart()
    }
}
