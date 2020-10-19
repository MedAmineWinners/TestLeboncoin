//
//  HomeViewController.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterItemsProtocol {
    
    var homeView = HomeView()
    var presenter: ViewToPresenterProtocol?
    var items = [Item]()
    var filteredItems = [Item]()
    var categories = [ItemCategory]()
    
    override func loadView() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.closeButton.addTarget(self, action: #selector(clearFilterList), for: .touchUpInside)
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateView()
        let rightButton = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(showFiltersList))
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.title = "Articles disponibles"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredItems.count == 0 {
            return items.count
        }
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        if filteredItems.count == 0 {
            cell.item = items[indexPath.row]
            cell.category = categories.first(where: {$0.id == items[indexPath.row].category_id})
        } else {
            cell.item = filteredItems[indexPath.row]
            cell.category = categories.first(where: {$0.id == filteredItems[indexPath.row].category_id})
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filteredItems.count > 0 ? filteredItems[indexPath.row] :  items[indexPath.row]
        if let category = categories.first(where: {$0.id == item.category_id}) {
            let detailsViewController = DetailsRouter.createModule(item: item, category: category)
            self.navigationController?.pushViewController(detailsViewController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @objc func clearFilterList() {
        self.filteredItems = [Item]()
        homeView.filterStackView.isHidden = true
        homeView.tableView.reloadDataAnimated()
    }
    
    @objc func showFiltersList() {
        self.filteredItems = [Item]()
        let filterController = FilterRouter.createModule(categories: categories)
        (filterController as! FilterViewController).delegate = self
        let navigationController = UINavigationController(rootViewController: filterController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func showItems(for category: ItemCategory) {
        self.filteredItems = self.items.filter( {$0.category_id == category.id})
        homeView.tableView.reloadDataAnimated()
        homeView.filterStackView.isHidden = false
        homeView.categoryLabel.text = category.name
    }
}

extension HomeViewController: PresenterToViewProtocol {
    func setCategories(categories: [ItemCategory]) {
        self.categories = categories
    }
    
    func showItems(items: [Item]) {
        self.items = sortItems(items: items)
        DispatchQueue.main.async {
            self.homeView.tableView.reloadDataAnimated()
        }
    }
    
    func showError(error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func sortItems(items: [Item]) -> [Item] {
        var sortedItems = items.sorted(by:  { ($0.creation_date.stringToDate()) > ($1.creation_date.stringToDate()) })
        sortedItems.sort { $0.is_urgent && !$1.is_urgent }
        return sortedItems
    }
}
