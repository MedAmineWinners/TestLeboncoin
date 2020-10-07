//
//  HomeViewController.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
    }
}

extension HomeViewController: PresenterToViewProtocol {
    func showCategories(categories: [Category]) {
        print("")
    }
    
    func showItems(items: [Item], categories: [Category]) {
        self.items = items
        self.categories = categories
        DispatchQueue.main.async {
            self.homeView.tableView.reloadData()
        }
    }
    
    func showError(error: String) {
        print("")
    }
}
