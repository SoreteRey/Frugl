//
//  CalendarViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class CalendarViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var budgetAmountLabel: UILabel!
    @IBOutlet weak var expensesAmountLabel: UILabel!
    @IBOutlet weak var upcomingExpensesTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        setMonthView()
        upcomingExpensesTableView.dataSource = self
        viewModel = CalendarViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBudgetAmount()
        upcomingExpensesTableView.reloadData()
    }
    
    // MARK: - Properties
    var selectedDate = Date()
    var totalSquares = [String]()
    var viewModel: CalendarViewModel!
    
    // MARK: - Functions
    func setCellsView() {
        let width = (calendarCollectionView.frame.size.width - 0.5) / 8
        let height = (calendarCollectionView.frame.size.height - 0.5) / 7
        
        let flowLayout = calendarCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        
        totalSquares.removeAll()
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 41) {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth) {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) +
        " " + CalendarHelper().yearString(date: selectedDate)
        calendarCollectionView.reloadData()
        
    }
    // MARK: - Actions
    @IBAction func nextMonthButtonTapped(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func previousMonthButtonTapped(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    func updateBudgetAmount() {
        if let budget = CurrentUser.shared.currentBudget {
            budgetAmountLabel.text = "\(budget.amount)"
        }
    }
} // End of class

// MARK: - Extensions
extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell()}
        
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        
        return cell
    }
}

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as? ExpenseTableViewCell else { return UITableViewCell() }
        let expense = viewModel.filterExpenses[indexPath.row]
        cell.updateUI(with: expense)
        return cell
    }
}

extension CalendarViewController: CalendarViewModelDelegate {
    func expensesLoadedSuccessfully() {
        upcomingExpensesTableView.reloadData()
    }
}
