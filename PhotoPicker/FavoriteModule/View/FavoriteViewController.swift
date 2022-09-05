//
//  TableViewController.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 03.09.2022.
//

import UIKit

class FavoriteViewController: UITableViewController {
    
    var presenter: FavoritePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite photos"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

// MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        setupCell(cell)
        
        let stackView = createCellContent()
        
        cell.addSubview(stackView)
        stackView.frame = cell.bounds
        return cell
    }
    
//MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.pushDetailView()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(view.frame.height / 8)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}

//MARK: - Favorite View Delegate
extension FavoriteViewController: FavoriteViewDelegate {
    
}

private extension FavoriteViewController {
    
    func setupCell(_ cell: UITableViewCell) {
        cell.backgroundColor = .systemGreen
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 10
    }
    
    func createCellContent() -> UIStackView {
        let image = UIImage(systemName: "person.circle")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        let authorNameLabel = UILabel()
        authorNameLabel.text = "Name Lastname"
        authorNameLabel.font = .systemFont(ofSize: 20)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, authorNameLabel])
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }
}

//MARK: - SwiftUI preview provider
import SwiftUI

struct FavoriteViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
    }
    
    struct ContainerView: UIViewControllerRepresentable{
        let viewController = FavoriteViewController()
        func makeUIViewController(
            context: UIViewControllerRepresentableContext<FavoriteViewControllerProvider.ContainerView>
        ) -> FavoriteViewController {
            
            return viewController
        }
        
        func updateUIViewController(
            _ uiViewController: FavoriteViewControllerProvider.ContainerView.UIViewControllerType,
            context: UIViewControllerRepresentableContext<FavoriteViewControllerProvider.ContainerView>
        ) {
            
        }
    }
    
}
