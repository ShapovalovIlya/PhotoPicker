//
//  Adapter.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

protocol AdapterProtocol {
    func getRandomPhoto(complition: @escaping(Result<PhotoModel, Error>) -> Void)
    
}

final class Adapter: AdapterProtocol {
    
    private let dataFetcher: DataFetcherServiceProtocol?
    
    init(dataFetcher: DataFetcherServiceProtocol = DataFetcherService()) {
        self.dataFetcher = dataFetcher
    }
    
    func getRandomPhoto(complition: @escaping(Result<PhotoModel, Error>) -> Void) {
        dataFetcher?.fetchRandomPhoto { result in
            switch result {
            case .failure(let error):
                complition(.failure(error))
            case .success(let decodedPhoto):
                guard
                    let photo = decodedPhoto,
                    let imageURL = URL(string: photo.imageURLs.thumb)
                else {
                    return
                    
                }
                
                let newPhoto = PhotoModel(
                    id: photo.id,
                    createAt: photo.createdAt,
                    backgroundHEX: photo.backgroundColor,
                    downloads: photo.downloads,
                    location: photo.location.name,
                    imageURL: imageURL,
                    author: photo.author.name
                )
                
                complition(.success(newPhoto))
            }
            
        }
    }
    
}
