//
//  UUpdateTCell.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/16.
//

import UIKit

class UUpdateTCell: UBaseTableViewCell {
    
    private lazy var coverView: UIImageView = {
        let cw = UIImageView()
        cw.contentMode = .scaleAspectFill
        cw.layer.cornerRadius = 5
        cw.layer.masksToBounds = true
        return cw
    }()
    
    private lazy var tipLabel: UILabel = {
        let tl = UILabel()
        tl.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        tl.textColor = UIColor.white
        tl.font = UIFont.systemFont(ofSize: 9)
        return tl
    }()

    override func configUI() {
        
        contentView.addSubview(coverView)
        coverView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10))
        }
        
        coverView.addSubview(tipLabel)
        tipLabel.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        let line = UIView().then{
            $0.backgroundColor = UIColor.background
        }
        contentView.addSubview(line)
        line.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(10)
        }
    }
    
    var model: ComicModel? {
        didSet {
            guard let model = model else { return }
            coverView.kf.setImage(urlString: model.cover)
            tipLabel.text = "    \(model.description ?? "")"
        }
    }
}

