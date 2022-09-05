//
//  ModelController.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

protocol LibraryModelInterface {
    func getPhotoLibraryCount() -> Int?
    func getLibraryPhotoURL(fromIndex index: Int) -> URL?
}

protocol FavoriteModelInterface {
    func getFavoritePhotoCount() -> Int?
    func getFavoritePhotoURL(fromIndex index: Int) -> URL?
}

typealias ModelControllerProtocol = LibraryModelInterface & FavoriteModelInterface

final class ModelController: ModelControllerProtocol {
    
    var adapter: AdapterProtocol?
    private var photoLibrary = [PhotoModel]()
    
    private var favoritePhotos: [PhotoModel] {
        var favorite = [PhotoModel]()
        
        for photo in photoLibrary {
            if photo.isFavorite {
                favorite.append(photo)
            }
        }
        
        return favorite
    }
    
    init(adapter: AdapterProtocol = Adapter()) {
        self.adapter = adapter
        downloadPhotos()
    }
    
    //MARK: - Library module data
    func getPhotoLibraryCount() -> Int? {
        return photoLibrary.count
    }
    
    func getLibraryPhotoURL(fromIndex index: Int) -> URL? {
        return photoLibrary[index].thumbImageURL
    }
    
    //MARK: - Favorite module data
    func getFavoritePhotoCount() -> Int? {
        return favoritePhotos.count
    }
    
    func getFavoritePhotoURL(fromIndex index: Int) -> URL? {
        return favoritePhotos[index].thumbImageURL
    }
    
    //MARK: - Detail module data
    
    
}

private extension ModelController {
    
    func downloadPhotos() {
        
        adapter?.getPhotos{ result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let photoArray):
                self.photoLibrary = photoArray
            }
        }
        
    }
        
}
