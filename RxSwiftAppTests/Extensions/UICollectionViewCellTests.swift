//
//  UICollectionViewCellTests.swift
//  RxSwiftAppTests
//
//  Created by Bartłomiej Lańczyk on 30/06/2021.
//

import XCTest
@testable import RxSwiftApp

private class ExampleCell: UICollectionViewCell {}

class UICollectionViewCellTests: XCTestCase {
    func testReuseIdentifier() {
        XCTAssertEqual(ExampleCell.reuseIdentifier, "ExampleCell")
    }
}
