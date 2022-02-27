//
//  UCollectionViewSectionBackgroundLayout.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/16.
//

import UIKit

private let SectionBackground = "UCollectionReusableView"

protocol UCollectionViewSectionBackgroundLayoutDelegateLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        backgroundColorForSectionAt section: Int) -> UIColor
}

class UCollectionViewSectionBackgroundLayout: UICollectionViewFlowLayout {
    
    
}
