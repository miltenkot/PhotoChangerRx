//
//  ViewController.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 08/06/2021.
//

import UIKit
import Photos
import RxSwift

class MainViewController: UIViewController {
    var viewModel: MainViewModel!
    var filterService =  FilterService(context: CIContext())
    
    private var contentView: MainContentView {
        view as! MainContentView
    }
    
    let disposeBag = DisposeBag()
    
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
    }
    
    @objc func didPressPlusButton() {
        let viewModel = PhotosCollectionViewModel()
        let controller = PhotosCollectionViewController(viewModel: viewModel)
        controller.viewModel.selectedPhoto.subscribe(onNext: { [weak self] image in
            if let image = image {
                DispatchQueue.main.async {
                    self?.updateUI(with: image)
                }
            }
        }).disposed(by: disposeBag)
        self.navigationController?.show(controller, sender: self)
    }
    
    @objc func didPressFilterButton() {
        guard let sourceImage = self.contentView.imageView.image else {
            return
        }
        filterService.applyFilter(to: sourceImage).subscribe(onNext: { filteredImage in
            DispatchQueue.main.async {
                self.contentView.imageView.image = filteredImage
            }
        }).disposed(by: disposeBag)
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
    
    private func updateUI(with image: UIImage) {
        self.contentView.imageView.image = image
        self.contentView.button.isHidden = false
        self.contentView.button.addTarget(self, action: #selector(didPressFilterButton), for: .touchUpInside)
    }
}

