//
//  TabBarController.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 02.09.2022.
//

import UIKit

enum TabBarItems {
    case library
    case favorite
    
    var index: Int {
        switch self {
        case .library:
            return 0
        case .favorite:
            return 1
        }
    }
    
    var item: UITabBarItem {
        switch self {
        case .library:
            return UITabBarItem(title: "Library", image: UIImage(systemName: "tray.full.fill"), tag: index)
        case .favorite:
            return UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart.text.square"), tag: index)
        }
    }
}

final class TabBarController: UITabBarController {
    
    required init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewControllers = viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .systemBlue
    }
}

