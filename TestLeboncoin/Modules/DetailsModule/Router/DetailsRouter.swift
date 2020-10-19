//
//  DetailsRouter.swift
//  TestLeboncoin
//
//  Created by Stimlog on 08/10/2020.
//

import Foundation
import UIKit
class DetailsRouter {
    class func createModule(articleViewModel: ArticleViewModel) -> UIViewController {
        let view = DetailsViewController()
        view.articleViewModel = articleViewModel
        return view
    }
}
