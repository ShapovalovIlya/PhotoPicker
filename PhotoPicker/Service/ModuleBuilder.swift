//
//  AssemblyBuilder.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 02.09.2022.
//

import UIKit

protocol ModuleBuilderInterface {
    func makeLibraryViewController(router: LibraryRouter) -> UIViewController
    func makeDetailViewController(router: DetailRouter) -> UIViewController
    func makeFavoriteViewController(router: FavoriteRouter) -> UITableViewController
    func makeAlertMessage(ofType type: AlertType) -> UIAlertController
}

final class ModuleBuilder: ModuleBuilderInterface {
    func makeLibraryViewController(router: LibraryRouter) -> UIViewController {
        let view = LibraryViewController()
        let adapter = Adapter()
        let model = ModelController(adapter: adapter)
        let presenter = LibraryPresenter(view: view, router: router, model: model)
        view.presenter = presenter
        return view
    }
    
    func makeDetailViewController(router: DetailRouter) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func makeFavoriteViewController(router: FavoriteRouter) -> UITableViewController {
        let view = FavoriteViewController()
        let presenter = FavoritePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    
    
    func makeAlertMessage(ofType type: AlertType) -> UIAlertController {
        let alertController = UIAlertController(
            title: nil,
            message: type.message,
            preferredStyle: .alert
        )
        
        return alertController
    }
}

enum AlertType {
    case Add
    case Delete
    
    var message: String {
        switch self {
        case .Add:
            return "Added to favorite!"
        case .Delete:
            return "Removed from favorite!"
        }
    }
    
}
