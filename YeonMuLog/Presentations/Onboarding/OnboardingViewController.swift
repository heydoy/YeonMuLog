//
//  OnboardingViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit

class OnboardingViewController: BaseViewController {
    // MARK: - Properties
    let mainView = OnboardingView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @objc func goMainButtonTapped(_ sender: UIButton) {
        let vc = TaraeViewController()
        let rootViewController = UINavigationController(rootViewController: vc)
        
        rootViewController.modalPresentationStyle = .fullScreen
        rootViewController.modalTransitionStyle = .crossDissolve
        
        present(rootViewController, animated: true)
    }
    
    // MARK: - Helpers
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.goMainButton.addTarget(self, action: #selector(goMainButtonTapped), for: .touchUpInside)
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
