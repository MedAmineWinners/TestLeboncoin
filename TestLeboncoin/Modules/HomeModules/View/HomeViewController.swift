//
//  HomeViewController.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var homeView = HomeView()
    var presenter: ViewToPresenterProtocol?
    var items = [Item]()
    var categories = [Category]()
    
    override func loadView() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
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
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        cell.item = items[indexPath.row]
        cell.category = categories.first(where: {$0.id == items[indexPath.row].category_id})
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    @objc func showFiltersList() {
        let filterController = FilterRouter.createModule(categories: categories)
        let navigationController = UINavigationController(rootViewController: filterController)
        self.present(navigationController, animated: true, completion: nil)
    }
}

extension HomeViewController: PresenterToViewProtocol {
    func showCategories(categories: [Category]) {
        print("")
    }
    
    func showItems(items: [Item], categories: [Category]) {
        var sortedItems = items.sorted(by:  { ($0.creation_date?.stringToDate())! > ($1.creation_date?.stringToDate())! })
        sortedItems.sort { $0.is_urgent! && !$1.is_urgent! }
        self.items = sortedItems
        self.categories = categories
        
        DispatchQueue.main.async {
            self.homeView.tableView.reloadData()
        }
    }
    
    func showError(error: String) {
        print("")
    }
}
