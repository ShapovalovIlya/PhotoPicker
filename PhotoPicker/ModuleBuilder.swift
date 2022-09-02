//
//  AssemblyBuilder.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 02.09.2022.
//

import UIKit

protocol ModuleBuilderInterface {
    func makeLibraryMainVC(router: LibraryRouter) -> UIViewController
}

final class ModuleBuilder: ModuleBuilderInterface {
    func makeLibraryMainVC(router: LibraryRouter) -> UIViewController {
        let view = LibraryMainViewController()
        let presenter = LibraryPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    
}
