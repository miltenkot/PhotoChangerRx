//
//  PhotosCollectionViewModel.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 29/06/2021.
//

import UIKit
import Photos
import RxSwift

class PhotosCollectionViewModel: NSObject, UICollectionViewDelegate {
    private var images = [PHAsset]()
    var reloadTableViewClosure: (()->())?
    var onDissmis: (() -> Void)?
    
    private let selectedSubjectPhoto = PublishSubject<UIImage?>()
    var selectedPhoto: Observable<UIImage?> {
        return selectedSubjectPhoto.asObservable()
    }
    
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
}

extension PhotosCollectionViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = self.images[indexPath.row]
        PHImageManager.default().requestImage(for: selectedAsset,
                                              targetSize: CGSize(width: 300,
                                                                 height: 300),
                                              contentMode: .aspectFit,
                                              options: nil) { [weak self] image, info in
            guard let info = info else {
                return
            }
            
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            
            if !isDegradedImage {
                if let image = image {
                    self?.selectedSubjectPhoto.onNext(image)
                    self?.onDissmis?()
                }
            }
            
        }
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


