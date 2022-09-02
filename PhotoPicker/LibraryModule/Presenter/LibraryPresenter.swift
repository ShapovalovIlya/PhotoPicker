//
//  LibraryPresenter.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 03.09.2022.
//

import Foundation
protocol LibraryMainViewDelegate: AnyObject {
    
}

protocol LibraryPresenterProtocol {
    init(view: LibraryMainViewDelegate, router: LibraryRouter)
}

final class LibraryPresenter: LibraryPresenterProtocol {
    
    var router: LibraryRouter?
    weak var view: LibraryMainViewDelegate?
    
    init(view: LibraryMainViewDelegate, router: LibraryRouter) {
        self.view = view
        self.router = router
    }
    
    
}
