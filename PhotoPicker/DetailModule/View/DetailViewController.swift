//
//  LibraryDetailViewController.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 03.09.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //MARK: - Public properties
    var presenter: DetailPresenterProtocol?
    
    //MARK: - Private properties
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 30)
        label.text = "Name Lastname"
        return label
    }()
    
    private lazy var locationStackView = UIStackView()
    
    private lazy var locationMark: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "mappin.and.ellipse")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "Location"
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var dateStackView = UIStackView()
    
    private lazy var dateMark: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "calendar")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "DD.MM.YEAR"
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var downloadsStackView = UIStackView()
    
    private lazy var downloadsMark: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "square.and.arrow.down")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    private lazy var downloadsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "Downloads: 55"
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - Life cycle
    override func loadView() {
        super.loadView()
        
        setupView()
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        presenter?.setPhotoModel()
    }
    
    //MARK: - Private methods
    @objc private func favoriteButtonTap() {
        
    }
}

//MARK: - Library View Delegate
extension DetailViewController: DetailViewDelegate {
    
    func setPhotoModel(model: PhotoModel?) {
        guard let model = model else { return }
        imageView.kf.setImage(with: model.imageURL)
        authorNameLabel.text = model.author
        locationLabel.text = model.location
        dateLabel.text = model.createAt
        let downloadsCount = String(describing: model.downloads)
        downloadsLabel.text = "Downloads: \(downloadsCount)"
    }
    
}

private extension DetailViewController {
    
    //MARK: - Setup view
    func setupView() {
        view.backgroundColor = .white
        self.title = "Detail"
        
        locationStackView = UIStackView(arrangedSubviews: [locationMark, locationLabel])
        locationStackView.axis = .horizontal
        locationStackView.spacing = 10
        
        dateStackView = UIStackView(arrangedSubviews: [dateMark, dateLabel])
        dateStackView.axis = .horizontal
        dateStackView.spacing = 10
        
        downloadsStackView = UIStackView(arrangedSubviews: [downloadsMark, downloadsLabel])
        downloadsStackView.axis = .horizontal
        downloadsStackView.spacing = 10
        
        view.addSubviews([
            imageView,
            authorNameLabel,
            locationStackView,
            dateStackView,
            downloadsStackView,
        ])
    }
    
    func setupNavigationBar() {
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "star.fill"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTap)
        )
        navigationItem.rightBarButtonItem = favoriteButton
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
            
            locationStackView.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 10),
            locationStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            dateStackView.topAnchor.constraint(equalTo: locationStackView.bottomAnchor, constant: 10),
            dateStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            downloadsStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 10),
            downloadsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
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
