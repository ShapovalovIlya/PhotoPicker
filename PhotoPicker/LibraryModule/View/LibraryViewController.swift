//
//  ViewController.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 02.09.2022.
//

import UIKit
import Kingfisher

final class LibraryViewController: UIViewController {
    
    var presenter: LibraryPresenterProtocol?
    
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
    
}

//MARK: - Search Bar Delegate
extension LibraryViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchBar(false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text is: \(searchText)")
    }
}

//MARK: - Collection View Data Source
extension LibraryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getNumberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        setupCell(cell, withIndex: indexPath.item)
        return cell
    }
    
}

//MARK: - Collection View Delegate
extension LibraryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select item at index: \(indexPath.item)")
        presenter?.pushDetailView()
    }
}

//MARK: - Library View Delegate
extension LibraryViewController: LibraryViewDelegate {
    func success() {
        collectionView.reloadData()
    }
}

private extension LibraryViewController {
    
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
    
    func setupCell(_ cell: UICollectionViewCell, withIndex index: Int) {
        cell.backgroundColor = .black
        cell.layer.cornerRadius = 10
        let imageView = UIImageView()
        let imageURL = presenter?.getItemImageURL(byIndex: index)
        let placeHolder = UIImage(systemName: "square.and.arrow.down")
        imageView.kf.setImage(with: imageURL, placeholder: placeHolder)
        imageView.contentMode = .scaleAspectFit
        cell.backgroundView = imageView
    }
    
    //MARK: - Setup navigation bar
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        shouldShowSearchButton(true)
    }
    
    func shouldShowSearchButton(_ shouldShow: Bool) {
        if shouldShow {
            let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
            
            navigationItem.rightBarButtonItem = searchButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func shouldShowSearchBar(_ shouldShow: Bool) {
        shouldShowSearchButton(!shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
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

struct LibraryViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
    }
    
    struct ContainerView: UIViewControllerRepresentable{
        let viewController = LibraryViewController()
        func makeUIViewController(
            context: UIViewControllerRepresentableContext<LibraryViewControllerProvider.ContainerView>
        ) -> LibraryViewController {
            
            return viewController
        }
        
        func updateUIViewController(
            _ uiViewController: LibraryViewControllerProvider.ContainerView.UIViewControllerType,
            context: UIViewControllerRepresentableContext<LibraryViewControllerProvider.ContainerView>
        ) {
            
        }
    }
    
}
