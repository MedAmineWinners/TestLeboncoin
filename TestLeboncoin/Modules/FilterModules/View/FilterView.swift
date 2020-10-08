//
//  FilterView.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import UIKit

class FilterView: UIView {
    let tableView = UITableView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        createSubviews()
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: "FilterTableViewCell")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }

    func createSubviews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
