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
    let imageURL: URL
    let author: String
    
    init(id: String, createAt: String, backgroundHEX: String, downloads: Int, location: String, imageURL: URL, author: String) {
        self.id = id
        self.createAt = createAt
        self.backgroundHEX = backgroundHEX
        self.downloads = downloads
        self.location = location
        self.imageURL = imageURL
        self.author = author
    }
}
