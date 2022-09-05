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
    let backgroundColor: String
    let downloads: Int
    let location: String
    let imageURL: String
    let author: String
    
    init(id: String, createAt: String, backgroundColor: String, downloads: Int, location: String, imageURL: String, author: String) {
        self.id = id
        self.createAt = createAt
        self.backgroundColor = backgroundColor
        self.downloads = downloads
        self.location = location
        self.imageURL = imageURL
        self.author = author
    }
}
