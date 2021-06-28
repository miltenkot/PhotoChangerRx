//
//  PhotosCollectionViewController.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 26/06/2021.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {
    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        print(#function)
        setupNavigationView()
        populatePhotos()
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(#function)
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection: Int) -> Int {
        print(#function)
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,                                      cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        print(#function)
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
                print(#function + "DispatchQueue")
            }
            
        }
        
        return cell
    }
    
    private func populatePhotos() {
        print(#function)
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
    
    private func setupNavigationView() {
        print(#function)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: NavigationItemTitle.cancel,
            style: .plain,
            target: self,
            action: #selector(didPressCancelButton)
        )
    }
    
    @objc func didPressCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
