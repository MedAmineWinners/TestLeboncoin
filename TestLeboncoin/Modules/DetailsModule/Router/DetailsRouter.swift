//
//  DetailsRouter.swift
//  TestLeboncoin
//
//  Created by Stimlog on 08/10/2020.
//

import Foundation
import UIKit
class DetailsRouter {
    class func createModule(item: Item, category: Category) -> UIViewController {
        let view = DetailsViewController()
        view.item = item
        view.category = category
        return view
    }
}
