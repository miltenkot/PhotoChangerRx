//
//  PhotosCollectionViewController.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 26/06/2021.
//

import UIKit

class PhotosCollectionViewController: UIViewController {
    private var viewModel: PhotosCollectionViewModel!
    private var contentView: PhotosCollectionContentView {
        view as! PhotosCollectionContentView
    }
    private var collectionView: UICollectionView {
        contentView.collectionView
    }
    
    // MARK: - Public
    
    init(viewModel: PhotosCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = PhotosCollectionContentView()
    }
    
    override func viewDidLoad() {
        setupNavigationView()
        setupCollectionView()
        bindViewModel()
        viewModel.populatePhotos()
    }
    
    @objc func didPressCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private
    
    private func setupNavigationView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: NavigationItemTitle.cancel,
            style: .plain,
            target: self,
            action: #selector(didPressCancelButton)
        )
    }
    
    private func setupCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
    
    private func bindViewModel() {
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

