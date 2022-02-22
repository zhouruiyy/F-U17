//
//  UChapterCCell.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/15.
//

import UIKit

class UChapterCCell: UBaseCollectionViewCell {
    
    lazy var nameLabel: UILabel = {
        let nl = UILabel()
        nl.font = UIFont.systemFont(ofSize: 16)
        return nl
    }()
    
    override func configUI() {
        contentView.backgroundColor = .white
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)) }
    }
    
    var chapterStatic: ChapterStaticModel? {
        didSet {
            guard let chapterStatic = chapterStatic else {
                return
            }
            nameLabel.text = chapterStatic.name
        }
    }
}
