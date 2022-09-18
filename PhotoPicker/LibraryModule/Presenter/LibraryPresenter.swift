//
//  LibraryPresenter.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 03.09.2022.
//

import Foundation

protocol LibraryViewDelegate: AnyObject {
    func success()
}

protocol LibraryPresenterProtocol: AnyObject {
    init(view: LibraryViewDelegate, router: LibraryRouter, model: LibraryModelInterface)
    func pushDetailView(withId id: String)
    func getNumberOfItems() -> Int?
    func getModelForItem(withIndex index: Int) -> PhotoModel?
}

final class LibraryPresenter: LibraryPresenterProtocol {
    
    var router: LibraryRouter?
    var model: LibraryModelInterface?
    weak var view: LibraryViewDelegate?
    
    init(view: LibraryViewDelegate, router: LibraryRouter, model: LibraryModelInterface) {
        self.view = view
        self.router = router
        self.model = model
        
        getPhotoLibrary()
    }
    
    func getNumberOfItems() -> Int? {
        return model?.getPhotoLibraryCount()
    }
    
    func getModelForItem(withIndex index: Int) -> PhotoModel? {
        return model?.getPhotoModel(withIndex: index)
    }
    
    func pushDetailView(withId id: String) {
        
    }
    
}

private extension LibraryPresenter {
    
    func getPhotoLibrary() {
        model?.getPhotoLibrary { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let message):
                self.view?.success()
                print(message)
            case .failure(let error):
                self.router?.showPopupMessage(ofType: .error, withMessage: error.localizedDescription)
            }
        }
    }
    
}
