//
//  PhotosCollectionViewModel.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 29/06/2021.
//

import UIKit
import Photos

class PhotosCollectionViewModel: NSObject, UICollectionViewDelegate {
    private var images = [PHAsset]()
    var reloadTableViewClosure: (()->())?
    
    override init() {
        super.init()
    }
    
    // MARK: - Public
    
    func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: .image, options: nil)
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                self?.images.reverse()
                self?.reloadTableViewClosure?()
            }
        }
    }
}

extension PhotosCollectionViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection: Int) -> Int {
        return self.images.count
    }
    
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
