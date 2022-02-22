//
//  URankCCell.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/13.
//

import UIKit

class URankCCell: UBaseCollectionViewCell {
    
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = .black
        return tl
    }()
    
    override func configUI() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.top.equalTo(iconView.snp.bottom)
        }
    }
    
    var model: RankingModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(urlString: model.cover)
            titleLabel.text = model.sortName
        }
    }
}
