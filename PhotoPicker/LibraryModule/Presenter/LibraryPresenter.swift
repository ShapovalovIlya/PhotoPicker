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

protocol LibraryPresenterProtocol {
    init(view: LibraryViewDelegate, router: LibraryRouter, model: LibraryModelInterface)
    func pushDetailView()
    func getNumberOfItems() -> Int?
    func getItemImageURL(byIndex index: Int) -> URL?
}

final class LibraryPresenter: LibraryPresenterProtocol {
    
    var router: LibraryRouter?
    var model: LibraryModelInterface?
    weak var view: LibraryViewDelegate?
    
    init(view: LibraryViewDelegate, router: LibraryRouter, model: LibraryModelInterface) {
        self.view = view
        self.router = router
        self.model = model
        
        model.downloadPhotoLibrary { result in
            switch result {
            case .success(_):
                view.success()
            case .failure(let error):
                router.showErrorAlert(ofType: .error, withMessage: error.localizedDescription)
            }
        }
        
    }
    
    func getNumberOfItems() -> Int? {
        return model?.getPhotoLibraryCount()
    }
    
    func getItemImageURL(byIndex index: Int) -> URL? {
        return model?.getLibraryPhotoURL(byIndex: index)
    }
    
    func pushDetailView() {
        router?.showDetailViewController()
    }
}
