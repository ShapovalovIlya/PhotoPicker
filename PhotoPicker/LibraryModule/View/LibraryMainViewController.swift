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
        searchBar.placeholder = "Search..."
        return searchBar
    }()
    
//    private let collectionView: UICollectionView = {
//        let collection = UICollectionView()
//        return collection
//    }()

    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        setupView()
        setDelegates()
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
//MARK: - Private methods
    @objc private func handleShowSearchBar() {
        shouldShowSearchBar(true)
        searchBar.becomeFirstResponder()
    }
    
    private func shouldShowSearchButton(_ shouldShow: Bool) {
        if shouldShow {
            let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
            
            navigationItem.rightBarButtonItem = searchButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func shouldShowSearchBar(_ shouldShow: Bool) {
        shouldShowSearchButton(!shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
}

//MARK: - Search Bar Delegate
extension LibraryMainViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchBar(false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text is: \(searchText)")
    }
}

//MARK: - Library Main View Delegate
extension LibraryMainViewController: LibraryMainViewDelegate {
    
}

private extension LibraryMainViewController {
    //MARK: - Setup view
    func setupView() {
        view.backgroundColor = .lightGray
        view.addSubviews([
            
        ])
    }
    
    //MARK: - Setup navigation bar
    func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        shouldShowSearchButton(true)
    }
    
    //MARK: - Set delegates
    func setDelegates() {
        searchBar.delegate = self
    }
    
    //MARK: - Set constraints
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
