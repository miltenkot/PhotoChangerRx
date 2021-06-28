//
//  UICollectionViewCell.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 28/06/2021.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
