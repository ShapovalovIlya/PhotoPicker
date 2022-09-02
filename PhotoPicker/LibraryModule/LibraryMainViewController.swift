//
//  ViewController.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 02.09.2022.
//

import UIKit

class LibraryMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .lightGray
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
