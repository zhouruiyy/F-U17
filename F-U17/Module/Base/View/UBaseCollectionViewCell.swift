//
//  UBaseCollectionViewCell.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/13.
//

import UIKit
import Reusable

class UBaseCollectionViewCell: UICollectionViewCell, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}
