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
    func makePopupMessage(ofType type: PopupType, withMessage message: String?) -> UIAlertController
}

final class ModuleBuilder: ModuleBuilderInterface {
    func makeLibraryViewController(router: LibraryRouter) -> UIViewController {
        let view = LibraryViewController()
        let model = ModelController()
        let presenter = LibraryPresenter(view: view, router: router, model: model)
        view.presenter = presenter
        view.title = "Photo Library"
        return view
    }
    
    func makeDetailViewController(router: DetailRouter) -> UIViewController {
        let view = DetailViewController()
        let model = ModelController()
        let presenter = DetailPresenter(view: view, router: router, model: model)
        view.presenter = presenter
        view.title = "About Photo"
        return view
    }
    
    func makeFavoriteViewController(router: FavoriteRouter) -> UITableViewController {
        let view = FavoriteViewController()
        let model = ModelController()
        let presenter = FavoritePresenter(view: view, router: router, model: model)
        view.presenter = presenter
        view.title = "Favorite photos"
        return view
    }
    
    
    
    func makePopupMessage(ofType type: PopupType, withMessage message: String?) -> UIAlertController {
        var alertController: UIAlertController
        switch type {
        case .add:
            alertController = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        case .delete:
            alertController = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        case .error:
            alertController = UIAlertController(title: type.title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(alertAction)
        }
        return alertController
    }
}

enum PopupType {
    case add
    case delete
    case error
    
    var title: String? {
        switch self {
        case .add:
            return nil
        case .delete:
            return nil
        case .error:
            return "Error!"
        }
    }
    
    var message: String? {
        switch self {
        case .add:
            return "Added to favorite!"
        case .delete:
            return "Removed from favorite!"
        case .error:
            return nil
        }
    }
    
}
