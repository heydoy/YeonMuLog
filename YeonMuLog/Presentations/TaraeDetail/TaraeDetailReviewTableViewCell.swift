//
//  TaraeDetailReviewTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/26.
//

import UIKit

class TaraeDetailReviewTableViewCell: UITableViewCell {
    // MARK: - Properties
    let flowLayout = ReviewCollectionViewLayout()
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
    
    func setData(query: UserReview) {
    
    }
    

    // MARK: - UI
    func configure() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0);
        collectionView.backgroundColor = .clear
        collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ReviewCollectionViewCell.self))
                
              
        self.contentView.addSubview(collectionView)
    }
    func setConstraints() {

        
    }
    func setUI() {
        backgroundColor = UIColor(red: 213/255, green: 182/255, blue: 251/255, alpha: 1)
    }
}
