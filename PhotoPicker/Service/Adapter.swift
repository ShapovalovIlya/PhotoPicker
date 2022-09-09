//
//  Adapter.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

protocol AdapterProtocol {
    func getPhotos(_ complition: @escaping(Result<[PhotoModel], Error>) -> Void)
}

final class Adapter: AdapterProtocol {
    
    private let dataFetcher: DataFetcherServiceProtocol?
    
    init(dataFetcher: DataFetcherServiceProtocol = DataFetcherService()) {
        self.dataFetcher = dataFetcher
    }
    
    func getPhotos(_ complition: @escaping(Result<[PhotoModel], Error>) -> Void) {
        dataFetcher?.fetchListOfPhotos { result in
            switch result {
            case .failure(let error):
                complition(.failure(error))
            case .success(let decodedPhotos):
                guard let photosArray = self.photoDataConverter(decodedPhotos: decodedPhotos) else { return }
                complition(.success(photosArray))
            }
            
        }
    }
    
    
    func getDetailPhoto(withId id: String, complition: @escaping(Result<PhotoModel,Error>) -> Void) {
        
    }
    
}

private extension Adapter {
    
    func photoDataConverter(decodedPhotos: [PhotoData]?) -> [PhotoModel]? {
        var photosArray = [PhotoModel]()
        guard let photos = decodedPhotos else { return nil }
        
        for photo in photos {
            
            guard
                let thumbImageURL = URL(string: photo.imageURLs.thumb),
                let regularImageURL = URL(string: photo.imageURLs.regular)
            else {
                continue
            }
            
            let newPhoto = PhotoModel(
                id: photo.id,
                createAt: photo.createdAt,
                backgroundHEX: photo.backgroundColor,
                downloads: photo.downloads ?? 0,
                location: photo.location?.name ?? "unknown",
                thumbImageURL: thumbImageURL,
                regularImageURL: regularImageURL,
                author: photo.author.name
            )
            photosArray.append(newPhoto)
        }
        return photosArray
    }
}
