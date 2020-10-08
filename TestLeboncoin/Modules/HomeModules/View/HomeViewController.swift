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
    var categories = [Category]()
    
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
    
    @objc func clearFilterList() {
        self.filteredItems = [Item]()
        homeView.stackView.isHidden = true
        homeView.tableView.reloadDataAnimated()
    }
    
    @objc func showFiltersList() {
        self.filteredItems = [Item]()
        let filterController = FilterRouter.createModule(categories: categories)
        (filterController as! FilterViewController).delegate = self
        let navigationController = UINavigationController(rootViewController: filterController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func showItems(for category: Category) {
        self.filteredItems = self.items.filter( {$0.category_id == category.id})
        homeView.tableView.reloadDataAnimated()
        homeView.stackView.isHidden = false
        homeView.categoryLabel.text = category.name
    }
}

extension HomeViewController: PresenterToViewProtocol {
    func setCategories(categories: [Category]) {
        self.categories = categories
    }
    
    func showItems(items: [Item]) {
        self.items = items
        DispatchQueue.main.async {
            self.homeView.tableView.reloadDataAnimated()
        }
    }
    
    func showError(error: String) {
        print("")
    }
}
