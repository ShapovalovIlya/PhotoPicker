//
//  LibraryPresenter.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 03.09.2022.
//

import Foundation

protocol LibraryViewDelegate: AnyObject {
    
}

protocol LibraryPresenterProtocol {
    init(view: LibraryViewDelegate, router: LibraryRouter)
    func pushDetailView()
}

final class LibraryPresenter: LibraryPresenterProtocol {
    
    var router: LibraryRouter?
    weak var view: LibraryViewDelegate?
    
    init(view: LibraryViewDelegate, router: LibraryRouter) {
        self.view = view
        self.router = router
    }
    
    func pushDetailView() {
        router?.showDetailViewController()
    }
}
