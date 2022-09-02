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
    
}

typealias RouterProtocol = RouterMain & LibraryRouter

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderInterface?
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderInterface) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialLibraryVC() {
        guard
            let navigationController = navigationController,
            let mainViewController = moduleBuilder?.makeLibraryMainVC(router: self)
        else {
            return
        }
        navigationController.viewControllers = [mainViewController]
        navigationController.tabBarItem = TabBarItems.library.item
    }
    
    
}
