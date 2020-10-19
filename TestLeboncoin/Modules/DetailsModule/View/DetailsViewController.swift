//
//  DetailsViewController.swift
//  TestLeboncoin
//
//  Created by Stimlog on 08/10/2020.
//

import UIKit

class DetailsViewController: UIViewController {

    var articleViewModel: ArticleViewModel?
    var detailsView = DetailsView()
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let articleViewModel = articleViewModel {
            if let url = articleViewModel.bigImage {
                detailsView.itemImageView.load(url: url)
            }
            detailsView.titleLabel.text = articleViewModel.title
            detailsView.priceLabel.text = articleViewModel.price
            detailsView.categoryLabel.text = articleViewModel.categoryName
            detailsView.dateLabel.text = articleViewModel.creationDate.stringToFormattedDate(with: DateFormatter())
            detailsView.urgentLabel.isHidden = !articleViewModel.isUrgent
            detailsView.descriptionLabel.text = articleViewModel.description
        }
    }
}
