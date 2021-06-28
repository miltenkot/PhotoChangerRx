//
//  ViewController.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 08/06/2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private lazy var contentView: MainContentView = {
        let view = MainContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setupAutoLayout()
        self.view.backgroundColor = .white
    }
    
    private func setupNavigationView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = NavigationItemTitle.cameraFilter
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didPressPlusButton)
        )
    }
    
    @objc func didPressPlusButton() {
        let collectionController = PhotosCollectionViewController(
            collectionViewLayout: UICollectionViewLayout()
        )
        let controller = UINavigationController(rootViewController: collectionController)
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.present(
            controller,
            animated: true,
            completion: nil)
    }
    
    private func setupAutoLayout() {
        self.view.addSubview(contentView)
        let contentViewConstraints: [NSLayoutConstraint] = [
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 40
            )
        ]

        NSLayoutConstraint.activate(contentViewConstraints)
    }
    
}

