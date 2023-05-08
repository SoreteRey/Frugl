//
//  ItemizationViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class ItemizationViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var budgetTotalLabel: UILabel!
    @IBOutlet weak var expensesTableView: UITableView!
    @IBOutlet weak var expectedBalanceLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expensesTableView.dataSource = self
        expensesTableView.delegate = self
        viewModel = ItemizationViewModel(delegate: self)
    }
    
    // MARK: - Properties
    var viewModel: ItemizationViewModel!
    
    // MARK: - Functions
    func updateUI() {
        if let budget = CurrentUser.shared.currentBudget {
            budgetTotalLabel.text = "\(budget.amount)"
        }
    }
} // End of Class
// MARK: - Extensions
extension ItemizationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Recurring"
        case 1: return "Individual"
        case 2: return "Savings"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as? ItemizationTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

extension ItemizationViewController: ItemizationViewModelDelegate {
    func budgetLoadedSuccessfully() {
        
    }
}
