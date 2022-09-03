//
//  ViewController.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 02.09.2022.
//

import UIKit

final class LibraryMainViewController: UIViewController {
    
    var presenter: LibraryViewPresenterProtocol!
    
    //MARK: - Private properties
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "Search..."
        return searchBar
    }()
    
    private var collectionView: UICollectionView!

    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        setupCollectionView()
        setupView()
        setDelegates()
        setupNavigationBar()
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

//MARK: - Collection View Data Source
extension LibraryMainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        cell.backgroundColor = .systemGreen
        let image = UIImage(systemName: "keyboard")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        cell.backgroundView = imageView
        cell.layer.cornerRadius = 10
        return cell
    }
    
}

//MARK: - Collection View Delegate
extension LibraryMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select item at index: \(indexPath.item)")
        presenter.tapOnItem()
    }
}

//MARK: - Library View Delegate
extension LibraryMainViewController: LibraryViewDelegate {
    
}

private extension LibraryMainViewController {
    
    //MARK: - Setup view
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    //MARK: - Setup collection view
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
    }
    
    //MARK: - Setup navigation bar
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        shouldShowSearchButton(true)
    }
    
    //MARK: - Set delegates
    func setDelegates() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: - Set collection view layout
    func collectionLayout() -> UICollectionViewLayout {
        let spacing = CGFloat(5)
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: spacing,
            bottom: 0,
            trailing: spacing
        )
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

//MARK: - SwiftUI preview provider
import SwiftUI

struct LibraryMainViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
    }
    
    struct ContainerView: UIViewControllerRepresentable{
        let viewController = LibraryMainViewController()
        func makeUIViewController(
            context: UIViewControllerRepresentableContext<LibraryMainViewControllerProvider.ContainerView>
        ) -> LibraryMainViewController {
            
            return viewController
        }
        
        func updateUIViewController(
            _ uiViewController: LibraryMainViewControllerProvider.ContainerView.UIViewControllerType,
            context: UIViewControllerRepresentableContext<LibraryMainViewControllerProvider.ContainerView>
        ) {
            
        }
    }
    
}
