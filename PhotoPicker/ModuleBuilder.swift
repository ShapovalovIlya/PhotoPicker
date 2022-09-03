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
}

final class ModuleBuilder: ModuleBuilderInterface {
    func makeLibraryViewController(router: LibraryRouter) -> UIViewController {
        let view = LibraryMainViewController()
        let presenter = LibraryPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func makeDetailViewController(router: DetailRouter) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
