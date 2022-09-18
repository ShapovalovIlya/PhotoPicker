//
//  Router.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 02.09.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderInterface? { get set }
}

protocol LibraryRouter {
    func showDetailViewController(withId id: String?)
    func showPopupMessage(ofType type: PopupType, withMessage message: String?)
}

protocol DetailRouter {
    func showPopupMessage(ofType type: PopupType, withMessage message: String?)
}

protocol FavoriteRouter {
    func showDetailViewController(withId id: String?)
    
}

typealias RouterProtocol = RouterMain & LibraryRouter & DetailRouter & FavoriteRouter

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderInterface?
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderInterface) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialViewController() {
        guard
            let navigationController = navigationController,
            let mainViewController = moduleBuilder?.makeLibraryViewController(router: self)
        else {
            return
        }
        navigationController.viewControllers = [mainViewController]
        navigationController.tabBarItem = TabBarItems.library.item
    }
    
    func showFavoriteViewController() {
        guard
            let navigationController = navigationController,
            let favoriteViewController = moduleBuilder?.makeFavoriteViewController(router: self)
        else {
            return
        }
        navigationController.viewControllers = [favoriteViewController]
        navigationController.tabBarItem = TabBarItems.favorite.item
    }
    
    func showDetailViewController(withId id: String?) {
        guard
            let navigationController = navigationController,
            let detailViewController = moduleBuilder?.makeDetailViewController(photoId: id, router: self)
        else {
            return
        }
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func showPopupMessage(ofType type: PopupType, withMessage message: String?) {
        guard
            let navigationController = navigationController,
            let alertViewController = moduleBuilder?.makePopupMessage(ofType: type, withMessage: message)
        else {
            return
        }
        navigationController.present(alertViewController, animated: true)
        
        if type != PopupType.error {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alertViewController.dismiss(animated: true)
            }
        }
        
    }
    
}
