//
//  LibraryPresenter.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 03.09.2022.
//

import Foundation

protocol LibraryViewDelegate: AnyObject {
    
}

protocol LibraryViewPresenterProtocol {
    init(view: LibraryViewDelegate, router: LibraryRouter)
    func tapOnItem()
}

final class LibraryPresenter: LibraryViewPresenterProtocol {
    
    var router: LibraryRouter?
    weak var view: LibraryViewDelegate?
    
    init(view: LibraryViewDelegate, router: LibraryRouter) {
        self.view = view
        self.router = router
    }
    
    func tapOnItem() {
        router?.showDetailViewController()
    }
}
