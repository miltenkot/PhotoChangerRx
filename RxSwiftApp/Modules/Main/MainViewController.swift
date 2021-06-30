//
//  ViewController.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 08/06/2021.
//

import UIKit

class MainViewController: UIViewController {
    private var contentView: MainContentView {
        view as! MainContentView
    }
    
    override func loadView() {
        view = MainContentView()
        view.backgroundColor = .white
    }
    
    // MARK: - Public
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
    }
    
    @objc func didPressPlusButton() {
        let collectionController = PhotosCollectionViewController(viewModel: PhotosCollectionViewModel())
        let controller = UINavigationController(rootViewController: collectionController)
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.present(
            controller,
            animated: true,
            completion: nil)
    }
    
    // MARK: - Private
    
    private func setupNavigationView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = NavigationItemTitle.cameraFilter
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didPressPlusButton)
        )
    }
}

