//
//  ModelController.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

protocol LibraryModelInterface {
    func getPhotoLibraryCount() -> Int?
    func getThumpPhotoURL(byIndex index: Int) -> URL?
    func downloadPhotoLibrary(_ complition: @escaping(Result<String, Error>) -> Void)
}

protocol FavoriteModelInterface {
    func getFavoritePhotoCount() -> Int?
    func getFavoritePhotoURL(byIndex index: Int) -> URL?
}

typealias ModelControllerProtocol = LibraryModelInterface & FavoriteModelInterface

final class ModelController: ModelControllerProtocol {
    
    var adapter: AdapterProtocol?
    
    private var photoLibrary = [PhotoModel]()
    private var favoritePhotos: [PhotoModel] {
        return photoLibrary.filter { $0.isFavorite == true }
    }
    
    init(adapter: AdapterProtocol) {
        self.adapter = adapter
    }
    
    func downloadPhotoLibrary(_ complition: @escaping(Result<String, Error>) -> Void) {
        adapter?.getPhotos{ result in
            switch result {
            case .failure(let error):
                complition(.failure(error))
            case .success(let photoArray):
                self.photoLibrary = photoArray
                complition(.success("Successfuly get photos!"))
            }
        }
        
    }
    
    //MARK: - Library module data
    func getPhotoLibraryCount() -> Int? {
        return photoLibrary.count
    }
    
    func getThumpPhotoURL(byIndex index: Int) -> URL? {
        return photoLibrary[index].imageURL
    }
    
    func getPhotoId(from index: Int, complition: @escaping(Result<PhotoModel, Error>) -> Void) {
        let photoId = photoLibrary[index].id
    }
    
    //MARK: - Favorite module data
    func getFavoritePhotoCount() -> Int? {
        return favoritePhotos.count
    }
    
    func getFavoritePhotoURL(byIndex index: Int) -> URL? {
        return favoritePhotos[index].imageURL
    }
    
    //MARK: - Detail module data
    
    
}

private extension ModelController {
        
}
