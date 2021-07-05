//
//  ViewController.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 08/06/2021.
//

import UIKit
import Photos

class MainViewController: UIViewController {
    var viewModel: MainViewModel!
    
    private var contentView: MainContentView {
        view as! MainContentView
    }
    
    override func loadView() {
        view = MainContentView()
        view.backgroundColor = .white
    }
    
    // MARK: - Public
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        bindData()
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
    
    
    private func bindData() {
       
    }
}

