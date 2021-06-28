//
//  PhotosCollectionViewCell.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 28/06/2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override var reuseIdentifier: String? {
        return PhotosCollectionViewCell.reuseIdentifier
    }
    
    // MARK: - Public
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAutoLayout()
    }
    
    // MARK: - Private
    
    private func setupAutoLayout() {
        addSubview(imageView)
        let constraints: [NSLayoutConstraint] = [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
}
