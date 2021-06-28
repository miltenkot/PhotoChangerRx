//
//  PhotosCollectionViewController.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 26/06/2021.
//

import UIKit
import Photos

class PhotosCollectionViewController: UIViewController {
    private var images = [PHAsset]()
    var collectionView: UICollectionView {
        contentView.collectionView
    }
    
    lazy var contentView: PhotosCollectionContentView = {
        let contentView = PhotosCollectionContentView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    // MARK: - Public
    
    override func viewDidLoad() {
        setupNavigationView()
        setupCollectionView()
        populatePhotos()
        setupAutoLayout()
        
    }
    
    @objc func didPressCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private
    
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: .image, options: nil)
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                self?.images.reverse()
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            }
        }
    }
    
    private func setupAutoLayout() {
        view.addSubview(contentView)
        
        let constraits: [NSLayoutConstraint] = [
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraits)
        
    }
    
    private func setupNavigationView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: NavigationItemTitle.cancel,
            style: .plain,
            target: self,
            action: #selector(didPressCancelButton)
        )
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
}

extension PhotosCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection: Int) -> Int {
        return self.images.count
    }
}

extension PhotosCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,                                      cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotosCollectionViewCell else {
            fatalError("Unexpected indexPath")
        }
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        manager.requestImage(for: asset,
                             targetSize: CGSize(width: 100, height: 100),
                             contentMode: .aspectFit,
                             options: nil) { image, _ in
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
            
        }
        
        return cell
    }
}
