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
    func pushDetailView()
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
        
        model.getPhotoLibrary { result in
            switch result {
            case .success(let message):
                view.success()
                print(message)
            case .failure(let error):
                router.showPopupMessage(ofType: .error, withMessage: error.localizedDescription)
            }
        }
        
    }
    
    func getNumberOfItems() -> Int? {
        return model?.getPhotoLibraryCount()
    }
    
    func getModelForItem(withIndex index: Int) -> PhotoModel? {
        return model?.getPhotoModel(withIndex: index)
    }
    
    func pushDetailView() {
        
    }
    
    func getPhotoDetail(withIndex index: Int) {
        
    }
    
}
