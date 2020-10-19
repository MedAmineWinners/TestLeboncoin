//
//  FilterViewController.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import UIKit

protocol FilterItemsProtocol {
    func showItems(for category: ItemCategory)
}

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: FilterViewToPresenterProtocol?
    var categories = [ItemCategory]()
    var filterView = FilterView()
    var delegate: FilterItemsProtocol?
    
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
        let rightButton = UIBarButtonItem(image: UIImage(named: "closeDark"), style: .done, target: self, action: #selector(dismissFilterList))
        navigationItem.rightBarButtonItem = rightButton
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
        self.delegate?.showItems(for: categories[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissFilterList() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController: FilterPresenterToViewProtocol {
    func showCategories(categories: [ItemCategory]) {
        self.categories = categories
    }
    
    func showError(error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
