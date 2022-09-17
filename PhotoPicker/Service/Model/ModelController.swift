//
//  ModelController.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

protocol LibraryModelInterface: AnyObject {
    func getPhotoLibraryCount() -> Int?
    func getPhotoModel(withIndex index: Int) -> PhotoModel?
    func getPhotoLibrary(_ complition: @escaping(Result<String, Error>) -> Void)
}

protocol FavoriteModelInterface: AnyObject {
    func getFavoritePhotoCount() -> Int?
    func getFavoritePhotoModel(withIndex index: Int) -> PhotoModel?
}

protocol DetailModelInterface: AnyObject {
    func getDetailedPhotoModel(withId id: String, complition: @escaping (Result<PhotoModel, Error>) -> Void)
}

typealias ModelControllerProtocol = LibraryModelInterface & FavoriteModelInterface & DetailModelInterface

final class ModelController: ModelControllerProtocol {
    
    private lazy var adapter = Adapter.shared
    private var photoLibrary = [PhotoModel]()
    private var favoritePhotos: [PhotoModel] {
        return photoLibrary.filter { $0.isFavorite == true }
    }
    
    
    func getPhotoLibrary(_ complition: @escaping(Result<String, Error>) -> Void) {
        adapter.getPhotos{ result in
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
    
    func getPhotoModel(withIndex index: Int) -> PhotoModel? {
        return photoLibrary[index]
    }
    
    func getPhotoId(from index: Int) {
        
    }
    
    //MARK: - Favorite module data
    func getFavoritePhotoCount() -> Int? {
        return favoritePhotos.count
    }
    
    func getFavoritePhotoModel(withIndex index: Int) -> PhotoModel? {
        return favoritePhotos[index]
    }
    
    //MARK: - Detail module data
    func getDetailedPhotoModel(withId id: String, complition: @escaping (Result<PhotoModel, Error>) -> Void) {
        adapter.getDetailPhoto(withId: id, complition: complition)
    }
 
}
