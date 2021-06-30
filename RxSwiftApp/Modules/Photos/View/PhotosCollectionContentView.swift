//
//  PhotosCollectionView.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 28/06/2021.
//

import UIKit

class PhotosCollectionContentView: UIView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 80, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: - Public
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
        setupCellIdentifier()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAutoLayout()
        setupCellIdentifier()
    }
    
    // MARK: - Private
    
    private func setupCellIdentifier() {
        collectionView.register(PhotosCollectionViewCell.self)
    }
    
    private func setupAutoLayout() {
        addSubview(collectionView)
        
        let constraints: [NSLayoutConstraint] = [
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
