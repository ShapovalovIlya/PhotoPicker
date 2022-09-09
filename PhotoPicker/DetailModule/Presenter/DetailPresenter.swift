//
//  DetailPresenter.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 03.09.2022.
//

import Foundation

protocol DetailViewDelegate: AnyObject {
    
}

protocol DetailPresenterProtocol {
    init(view: DetailViewDelegate, router: DetailRouter)
    func addPhotoToFavorite()
    func removePhotoFromFavorite()
    
}

final class DetailPresenter: DetailPresenterProtocol {
    
    var router: DetailRouter?
    weak var view: DetailViewDelegate?
    
    init(view: DetailViewDelegate, router: DetailRouter) {
        self.view = view
        self.router = router
    }
    
    func addPhotoToFavorite() {
        router?.showPopupMessage(ofType: .add, withMessage: nil)
    }
    
    func removePhotoFromFavorite() {
        router?.showPopupMessage(ofType: .delete, withMessage: nil)
    }
    
    
}
