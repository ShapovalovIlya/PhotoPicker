//
//  FavoritePresenter.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 04.09.2022.
//

import Foundation

protocol FavoriteViewDelegate: AnyObject {
    
}

protocol FavoritePresenterProtocol: AnyObject {
    init(view: FavoriteViewDelegate, router: FavoriteRouter, model: FavoriteModelInterface)
    func pushDetailView()
    func getNumberOfRows() -> Int?
    func getModelForRow(withIndex index: Int) -> PhotoModel?
}

final class FavoritePresenter: FavoritePresenterProtocol {
    
    var router: FavoriteRouter?
    var model: FavoriteModelInterface?
    weak var view: FavoriteViewDelegate?
    
    init(view: FavoriteViewDelegate, router: FavoriteRouter, model: FavoriteModelInterface) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    func getNumberOfRows() -> Int? {
        return model?.getFavoritePhotoCount()
    }
    
    func getModelForRow(withIndex index: Int) -> PhotoModel? {
        return model?.getFavoritePhotoModel(withIndex: index)
    }
    
    func pushDetailView() {
        
    }
    
}
