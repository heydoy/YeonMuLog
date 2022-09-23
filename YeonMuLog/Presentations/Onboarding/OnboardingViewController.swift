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
    let message = OnboardingMessage.messages
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
        
        mainView.collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: OnboardingCollectionViewCell.self))
        
        mainView.pageControl.numberOfPages = message.count
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return message.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OnboardingCollectionViewCell.self), for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setData(message[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

// SrollView
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let index = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        mainView.pageControl.currentPage = index
    }
}
