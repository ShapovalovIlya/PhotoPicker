//
//  LibraryPresenter.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 03.09.2022.
//

import Foundation
protocol LibraryMainView: AnyObject {
    
}

protocol LibraryPresenterProtocol {
    init(view: LibraryMainView, router: LibraryRouter)
}

final class LibraryPresenter: LibraryPresenterProtocol {
    
    var router: LibraryRouter?
    weak var view: LibraryMainView?
    
    init(view: LibraryMainView, router: LibraryRouter) {
        self.view = view
        self.router = router
    }
    
    
}
