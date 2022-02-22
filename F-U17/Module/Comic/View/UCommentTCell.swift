//
//  UCommentTCell.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/15.
//

import UIKit

class UCommentTCell: UBaseTableViewCell {
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var nickNameLabel: UILabel = {
        let nl = UILabel()
        nl.textColor = .gray
        nl.font = .systemFont(ofSize: 13)
        return nl
    }()
    
    lazy var contentTextView: UITextView = {
        let ct = UITextView()
        ct.isUserInteractionEnabled = false
        ct.font = .systemFont(ofSize: 13)
        ct.textColor = .black
        return ct
    }()
    
    override func configUI() {
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.top.equalTo(iconView)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(15)
        }
        
        contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            $0.left.right.equalTo(nickNameLabel)
            $0.bottom.greaterThanOrEqualToSuperview().offset(-10)
        }
    }
    
    var viewModel: UCommentViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            iconView.kf.setImage(urlString: viewModel.model?.face)
            nickNameLabel.text = viewModel.model?.nickname
            contentTextView.text = viewModel.model?.content_filter
        }
    }
}

class UCommentViewModel {
    
    var model: CommentModel?
    var height: CGFloat = 0
    
    convenience init(model: CommentModel) {
        self.init()
        self.model = model
        
        let tv = UITextView().then { $0.font = UIFont.systemFont(ofSize: 13) }
        tv.text = model.content_filter
        let height = tv.sizeThatFits(CGSize(width: UScreenWidth - 70, height: CGFloat.infinity)).height
        self.height = max(60, height + 45)
    }
    
    required init() {}
}
