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
    init(view: FavoriteViewDelegate, router: FavoriteRouter)
    func pushDetailView()
}

final class FavoritePresenter: FavoritePresenterProtocol {
    
    var router: FavoriteRouter?
    weak var view: FavoriteViewDelegate?
    
    init(view: FavoriteViewDelegate, router: FavoriteRouter) {
        self.view = view
        self.router = router
    }
    
    func pushDetailView() {
        router?.showDetailViewController()
    }
    
}
