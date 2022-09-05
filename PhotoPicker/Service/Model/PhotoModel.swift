//
//  PhotoModel.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

struct PhotoModel {
    let id: String
    let createAt: String
    let backgroundHEX: String
    let downloads: Int
    let location: String
    let thumbImageURL: URL
    let regularImageURL: URL
    let author: String
    let isFavorite: Bool = false
    
    init(id: String, createAt: String, backgroundHEX: String, downloads: Int, location: String, thumbImageURL: URL, regularImageURL: URL, author: String) {
        self.id = id
        self.createAt = createAt
        self.backgroundHEX = backgroundHEX
        self.downloads = downloads
        self.location = location
        self.thumbImageURL = thumbImageURL
        self.regularImageURL = regularImageURL
        self.author = author
    }
}
