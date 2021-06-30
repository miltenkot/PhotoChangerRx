//
//  UICollectionViewTests.swift
//  RxSwiftAppTests
//
//  Created by Bartłomiej Lańczyk on 30/06/2021.
//

import XCTest
@testable import RxSwiftApp

private class ExampleCell: UICollectionViewCell {}
private class WrongCell: UICollectionViewCell {}

class UICollectionViewTests: XCTestCase {
    func testRegisterReusableCell() {
        let layout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(ExampleCell.self)
            
            
        XCTAssertNotNil(collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCell.reuseIdentifier,
                                                           for:IndexPath(row: 0, section: 0)))
    }
    
    func testDequeueReusableCell() {
        let layout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(ExampleCell.self, forCellWithReuseIdentifier: ExampleCell.reuseIdentifier)
        XCTAssertNotNil(collectionView.dequeueReusableCell(for: ExampleCell.self,
                                                           for: IndexPath(row: 0, section: 0)))
    }
}
