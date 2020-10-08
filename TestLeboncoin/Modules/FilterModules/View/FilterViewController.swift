//
//  FilterViewController.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import UIKit

protocol FilterItemsProtocol {
    func showItems(for category: Category)
}

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var presenter: FilterViewToPresenterProtocol?
    var categories = [Category]()
    var filterView = FilterView()
    var delegate: FilterItemsProtocol!
    
    override func loadView() {
        filterView.tableView.delegate = self
        filterView.tableView.dataSource = self
        view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if categories.count == 0 {
            presenter?.updateView()
        } else {
            showCategories(categories: categories)
        }
        self.navigationItem.title = "Categories"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell") as! FilterTableViewCell
        cell.category = categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.showItems(for: categories[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController: FilterPresenterToViewProtocol {
    func showCategories(categories: [Category]) {
        
    }
    
    func showError(error: String) {
        
    }
}
