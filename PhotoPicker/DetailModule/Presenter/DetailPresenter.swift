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
}

final class DetailPresenter: DetailPresenterProtocol {
    
    var router: DetailRouter?
    weak var view: DetailViewDelegate?
    
    init(view: DetailViewDelegate, router: DetailRouter) {
        self.view = view
        self.router = router
    }
    
    func toggleFavoriteButton() {
        
    }
}
