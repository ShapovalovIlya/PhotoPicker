//
//  AssemblyBuilder.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 02.09.2022.
//

import UIKit

protocol ModuleBuilderInterface {
    func makeLibraryMainVC(router: RouterProtocol) -> UIViewController
}

final class ModuleBuilder: ModuleBuilderInterface {
    func makeLibraryMainVC(router: RouterProtocol) -> UIViewController{
        let view = LibraryMainViewController()
        return view
    }
    
    
}
