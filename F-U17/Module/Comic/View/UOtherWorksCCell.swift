//
//  UOtherWorksCCell.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/14.
//

import UIKit

class UOtherWorksCCell: UBaseCollectionViewCell {
    
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = .black
        tl.font = .systemFont(ofSize: 14)
        return tl
    }()
    
    private lazy var descLabel: UILabel = {
        let dl = UILabel()
        dl.textColor = .gray
        dl.font = .systemFont(ofSize: 12)
        return dl
    }()
    
    override func configUI() {
        
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.top)
        }
    }
    
    var model: OtherWorkModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(urlString: model.coverUrl, placeholder: (bounds.width > bounds.height) ? UIImage(named: "normal_placeholder_h") : UIImage(named: "normal_placeholder_v"))
            titleLabel.text = model.name
            descLabel.text = "更新至\(model.passChapterNum)话"
        }
    }

}
