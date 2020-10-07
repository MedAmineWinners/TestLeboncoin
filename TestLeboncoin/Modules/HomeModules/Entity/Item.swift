//
//  Item.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import Foundation
struct Item: Codable {
    let id: Int?
    let category_id: Int?
    let title: String?
    let description: String?
    let price: Double?
    let images_url: Images_url?
    let creation_date: String?
    let is_urgent: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case category_id = "category_id"
        case title = "title"
        case description = "description"
        case price = "price"
        case images_url = "images_url"
        case creation_date = "creation_date"
        case is_urgent = "is_urgent"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        category_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        images_url = try values.decodeIfPresent(Images_url.self, forKey: .images_url)
        creation_date = try values.decodeIfPresent(String.self, forKey: .creation_date)
        is_urgent = try values.decodeIfPresent(Bool.self, forKey: .is_urgent)
    }

}

struct Images_url: Codable {
    let small: String?
    let thumb: String?

    enum CodingKeys: String, CodingKey {
        case small = "small"
        case thumb = "thumb"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
    }
}
