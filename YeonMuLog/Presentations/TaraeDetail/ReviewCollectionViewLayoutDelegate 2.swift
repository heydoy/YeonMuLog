//
//  ReviewCollectionViewLayoutDelegate.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/26.
//

import Foundation
import UIKit

protocol ReviewCollectionViewLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForCellAt indexPath: IndexPath) -> CGFloat
}
