//
//  UTopCCell.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/13.
//

import UIKit

class UTopCCell: UBaseCollectionViewCell {
    
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func configUI() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    var model: TopModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(urlString: model.cover)
        }
    }
}
