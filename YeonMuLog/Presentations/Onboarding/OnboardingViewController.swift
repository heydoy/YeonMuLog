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
    
    // 현재 페이지를 체크할 용도의 변수
    var currentPage: Int = 0 {
        didSet {
            mainView.pageControl.currentPage = currentPage
        }
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingTimer()
    }
    
    // MARK: - Actions
    
    @objc func goMainButtonTapped(_ sender: UIButton) {
        let vc = CustomTabBarViewController()
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        present(vc, animated: true)
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
        return message.count // message.count 개의 배너지만 무한 스크롤을 위해 바꿔둠
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
        currentPage = index
        
    }
}

// 온보딩 애니메이션
extension OnboardingViewController {
    /// 자동 슬라이드 타이머. 타임인터벌마다 셀을 움직이게 한다.
    func onboardingTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            self.onboardingCellMove()
        }
    }
    /// 콜렉션뷰를 자동 슬라이드
    func onboardingCellMove() {
        
        currentPage += 1
        currentPage = currentPage % 3
        mainView.collectionView.scrollToItem(at: IndexPath(item: currentPage, section: 0) as IndexPath,
                                          at: .right, animated: true)
    
    }
}
