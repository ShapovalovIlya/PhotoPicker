//
//  LibraryDetailViewController.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 03.09.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //MARK: - Public properties
    var presenter: DetailViewPresenterProtocol!
    
    //MARK: - Private properties
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.text = "Name Lastname"
        return label
    }()
    
    private let locationMark: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "mappin.and.ellipse")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "Location"
        return label
    }()
    
    //MARK: - Life cycle
    override func loadView() {
        super.loadView()
        
        setupView()
        setConstraints()
    }
}

//MARK: - Library View Delegate
extension DetailViewController: DetailViewDelegate {
    
}

private extension DetailViewController {
    
    //MARK: - Setup view
    func setupView() {
        view.backgroundColor = .lightGray
        view.addSubviews([
            imageView,
            authorNameLabel,
            locationMark,
        ])
    }
    
    //MARK: - Set constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            authorNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            authorNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            locationMark.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 10),
            locationMark.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
        ])
    }
}

//MARK: - SwiftUI preview provider
import SwiftUI

struct LibraryDetailViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
    }
    
    struct ContainerView: UIViewControllerRepresentable{
        let viewController = DetailViewController()
        func makeUIViewController(
            context: UIViewControllerRepresentableContext<LibraryDetailViewControllerProvider.ContainerView>
        ) -> DetailViewController {
            
            return viewController
        }
        
        func updateUIViewController(
            _ uiViewController: LibraryDetailViewControllerProvider.ContainerView.UIViewControllerType,
            context: UIViewControllerRepresentableContext<LibraryDetailViewControllerProvider.ContainerView>
        ) {
            
        }
    }
    
}
