//
//  Adapter.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

final class Adapter {
    
    static let shared = Adapter()
    
    private lazy var dataFetcher = DataFetcherService.shared
    
    private init() { }
    
    func getPhotos(_ complition: @escaping(Result<[PhotoModel], Error>) -> Void) {
        dataFetcher.fetchListOfPhotos { [weak self] result in
            switch result {
            case .failure(let error):
                complition(.failure(error))
            case .success(let decodedPhotos):
                guard
                    let self = self,
                    let photosArray = self.photoDataConverter(decodedPhotos: decodedPhotos)
                else {
                    print("Adapter error: fail conversion data to model!")
                    return
                }
                complition(.success(photosArray))
            }
            
        }
    }
    
    
    func getDetailPhoto(withId id: String, complition: @escaping(Result<PhotoModel,Error>) -> Void) {
        dataFetcher.fetchPhoto(withId: id) { result in
            switch result {
            case .failure(let error):
                complition(.failure(error))
            case .success(let decodedPhoto):
                guard
                    let photo = decodedPhoto,
                    let imageURL = URL(string: photo.imageURLs.regular)
                else {
                    print("Adapter error: fail conversion data to model!")
                    return
                }
                
                let newPhoto = PhotoModel(
                    id: photo.id,
                    createAt: photo.createdAt,
                    backgroundHEX: photo.backgroundColor,
                    downloads: photo.downloads ?? 0,
                    location: photo.location?.name ?? "Unknown",
                    imageURL: imageURL,
                    author: photo.author.name)
                
                complition(.success(newPhoto))
            }
        }
    }
    
    func getSearchResult(withQuery query: String, complition: @escaping(Result<[PhotoModel], Error>) -> Void) {
        dataFetcher.fetchPhoto(withQuery: query) { [weak self] result in
            switch result {
            case .failure(let error):
                complition(.failure(error))
            case .success(let decodedPhotos):
                guard
                    let self = self,
                    let photosArray = self.photoDataConverter(decodedPhotos: decodedPhotos)
                else {
                    print("Adapter error: fail conversion data to model!")
                    return
                }
                complition(.success(photosArray))
            }
        }
    }
    
}

private extension Adapter {
    
    func photoDataConverter(decodedPhotos: [PhotoData]?) -> [PhotoModel]? {
        var photosArray = [PhotoModel]()
        guard let photos = decodedPhotos else { return nil }
        
        for photo in photos {
            
            guard let imageURL = URL(string: photo.imageURLs.thumb) else { continue }
            
            let newPhoto = PhotoModel(
                id: photo.id,
                createAt: photo.createdAt,
                backgroundHEX: photo.backgroundColor,
                downloads: photo.downloads ?? 0,
                location: photo.location?.name ?? "unknown",
                imageURL: imageURL,
                author: photo.author.name
            )
            photosArray.append(newPhoto)
        }
        return photosArray
    }
}
