//
//  DetailsViewController.swift
//  TestLeboncoin
//
//  Created by Stimlog on 08/10/2020.
//

import UIKit

class DetailsViewController: UIViewController {

    var item: Item!
    var category: Category!
    var detailsView = DetailsView()
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: item.images_url?.small ?? "") {
            detailsView.itemImageView.load(url: url)
        }
        detailsView.titleLabel.text = item.title
        detailsView.priceLabel.text = "\(item.price ?? 0.0)€"
        detailsView.categoryLabel.text = category.name
        detailsView.dateLabel.text = item.creation_date?.stringToFormattedDate()
        detailsView.urgentLabel.isHidden = !item.is_urgent!
        detailsView.descriptionLabel.text = item.description
    }
}
