//
//  DetailPresenter.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 03.09.2022.
//

import Foundation

protocol DetailViewDelegate: AnyObject {
    func setPhotoModel(model: PhotoModel?)
}

protocol DetailPresenterProtocol {
    init(view: DetailViewDelegate, router: DetailRouter, model: DetailModelInterface, photoId: String?)
    func setPhotoModel()
    func addPhotoToFavorite()
    func removePhotoFromFavorite()
}

final class DetailPresenter: DetailPresenterProtocol {
    
    var router: DetailRouter?
    var model: DetailModelInterface
    var photoId: String?
    weak var view: DetailViewDelegate?
    
    init(view: DetailViewDelegate, router: DetailRouter, model: DetailModelInterface, photoId: String?) {
        self.view = view
        self.router = router
        self.model = model
        self.photoId = photoId
    }
    
    public func setPhotoModel() {
        getDetailedPhotoModel(withId: photoId)
    }
    
    func addPhotoToFavorite() {
        router?.showPopupMessage(ofType: .add, withMessage: nil)
    }
    
    func removePhotoFromFavorite() {
        router?.showPopupMessage(ofType: .delete, withMessage: nil)
    }
    
}

private extension DetailPresenter {
    
    func getDetailedPhotoModel(withId id: String?) {
        guard let photoId = id else { return }
        model.getDetailedPhotoModel(withId: photoId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photoModel):
                self.view?.setPhotoModel(model: photoModel)
            case .failure(let error):
                self.router?.showPopupMessage(ofType: .error, withMessage: error.localizedDescription)
            }
        }
    }
    
}
