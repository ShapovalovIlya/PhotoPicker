//
//  PhotoData.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

struct PhotoData: Decodable {
    let id: String
    let createdAt: String
    let backgroundColor: String
    let downloads: Int
    let location: Location
    let imageURLs: imageURL
    let author: Author
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case backgroundColor = "color"
        case downloads = "downloads"
        case location = "location"
        case imageURLs = "urls"
        case author = "user"
    }
}

struct Location: Decodable {
    let name: String
}

struct imageURL: Decodable {
    let regular: String
    let small: String
    let thumb: String
}

struct Author: Decodable {
    let name: String
    let username: String
}
