//
//  UComicCHead.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/16.
//

import UIKit

typealias UComicCHeadMoreActionClosure = ()->Void

protocol UComicCHeadDelegate: AnyObject {
    func comicCHead(_ comicCHead: UComicCHead, moreAction button: UIButton)
}

class UComicCHead: UBaseCollectionReusableView {
    
    weak var delegate: UComicCHeadDelegate?
    
    private var moreActionClosure: UComicCHeadMoreActionClosure?
    
    lazy var iconView: UIImageView = {
        return UIImageView()
    }()
    
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = .systemFont(ofSize: 14)
        tl.textColor = .black
        return tl
    }()
    
    lazy var moreButton: UIButton = {
        let mn = UIButton(type: .system)
        mn.setTitle("•••", for: .normal)
        mn.setTitleColor(.lightGray, for: .normal)
        mn.titleLabel?.font = .systemFont(ofSize: 12)
        mn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return mn
    }()
    
    @objc func moreAction(button: UIButton) {
        delegate?.comicCHead(self, moreAction: button)
        
        guard let closure = moreActionClosure else { return }
        closure()
    }
    
    func moreActionClosure(_ closure: UComicCHeadMoreActionClosure?) {
        moreActionClosure = closure
    }
    
    override func configUI() {
        
        addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(5)
            $0.centerY.height.equalTo(iconView)
            $0.width.equalTo(200)
        }
        
        addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.width.equalTo(40)
        }
    }
}
