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
    
    // MARK: - Public
    
    func populatePhotos() {
        let fetch: () -> Void = { [weak self] in
            let assets = PHAsset.fetchAssets(with: .image, options: nil)
            assets.enumerateObjects { (object, count, stop) in
                self?.images.append(object)
            }
            self?.images.reverse()
            self?.reloadTableViewClosure?()
        }
        
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            fetch()
        case .restricted, .notDetermined, .denied, .limited:
            fatalError("Show alerts")
        default:
            fatalError("Show error alerts")
        }
    }
    
    // MARK: - Private methods
    
    private func requestAuthorization(completion: ((PHAuthorizationStatus) -> Void)?) {
        PHPhotoLibrary.requestAuthorization { authorizationStatus in
            DispatchQueue.main.async {
                completion?(authorizationStatus)
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
        let cell = collectionView.dequeueReusableCell(for: PhotosCollectionViewCell.self, for: indexPath)
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


