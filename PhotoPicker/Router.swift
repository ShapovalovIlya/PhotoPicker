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
    func showDetailViewController()
}

protocol DetailRouter {
    
}

typealias RouterProtocol = RouterMain & LibraryRouter & DetailRouter

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
    
    func showDetailViewController() {
        guard
            let navigationController = navigationController,
            let detailViewController = moduleBuilder?.makeDetailViewController(router: self)
        else {
            return
        }
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
