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
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        setupNavigationView()
        setupCollectionView()
        populatePhotos()
        
    }
    
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: .image, options: nil)
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                self?.images.reverse()
                DispatchQueue.main.async {
                    self?.collectionView?.reloadData()
                }
                
            }
        }
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
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView ?? UICollectionView())
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
    }
    
    @objc func didPressCancelButton() {
        self.dismiss(animated: true, completion: nil)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotosCollectionViewCell else {
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
