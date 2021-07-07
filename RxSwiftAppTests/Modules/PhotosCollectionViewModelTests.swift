//
//  PhotosCollectionViewModelTests.swift
//  RxSwiftAppTests
//
//  Created by Bartłomiej Lańczyk on 30/06/2021.
//

import XCTest
@testable import RxSwiftApp

class PhotosCollectionViewModelTests: XCTestCase {

    func testPhotosReverseInPHArray() {
        let model = PhotosCollectionViewModel()
        
        model.populatePhotos()
    }
}
