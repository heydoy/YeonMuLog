//
//  TaraeDetailReviewTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/26.
//

import UIKit

class TaraeDetailReviewTableViewCell: UITableViewCell {
    // MARK: - Properties
    //let flowLayout = ReviewCollectionViewLayout()
    var collectionView: UICollectionView!
    
    // MARK: - Inintialisation
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
        setUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: UserReview) {
    
    }
    
    // MARK: - UI
    func configure() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 8
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 50, right: 0)
        collectionView.backgroundColor = .clear
        collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ReviewCollectionViewCell.self))
        collectionView.register(NoReviewCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: NoReviewCollectionViewCell.self))
                
        self.contentView.addSubview(collectionView)
    }
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    func setUI() {
        backgroundColor = UIColor(red: 240/255, green: 235/255, blue: 243/255, alpha: 1)
    }
}
