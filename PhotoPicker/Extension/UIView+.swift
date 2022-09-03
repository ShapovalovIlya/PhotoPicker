//
//  UIView+.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 03.09.2022.
//

import UIKit

extension UIView {
    final func addSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}
