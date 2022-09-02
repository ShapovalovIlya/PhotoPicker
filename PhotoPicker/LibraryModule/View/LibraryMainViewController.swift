//
//  ViewController.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 02.09.2022.
//

import UIKit

final class LibraryMainViewController: UIViewController {
    
    var presenter: LibraryPresenterProtocol!
    //MARK: - Private properties
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
         
        return searchBar
    }()

    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
}

extension LibraryMainViewController: LibraryMainView {
    
}

private extension LibraryMainViewController {
    func setupView() {
        view.backgroundColor = .lightGray
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
        
        ])
    }
}

//MARK: - SwiftUI preview provider
import SwiftUI

struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
    }
    
    struct ContainerView: UIViewControllerRepresentable{
        let viewController = LibraryMainViewController()
        func makeUIViewController(
            context: UIViewControllerRepresentableContext<ViewControllerProvider.ContainerView>
        ) -> LibraryMainViewController {
            
            return viewController
        }
        
        func updateUIViewController(
            _ uiViewController: ViewControllerProvider.ContainerView.UIViewControllerType,
            context: UIViewControllerRepresentableContext<ViewControllerProvider.ContainerView>
        ) {
            
        }
    }
    
}
